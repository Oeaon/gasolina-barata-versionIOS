import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_info.dart';
import '../core/nearby_search.dart';
import '../core/station.dart';
import '../data/location.dart';
import '../data/settings_store.dart';
import '../l10n/app_localizations.dart';
import '../monetization/monetization.dart';
import '../monetization/monetization_ui.dart';
import 'components.dart';
import 'format.dart';
import 'main_controller.dart';

/// Por debajo de unos céntimos no merece la pena destacar el ahorro.
const _minSavingEur = 0.10;

class StationsScreen extends StatelessWidget {
  const StationsScreen({
    super.key,
    required this.controller,
    required this.monetization,
    required this.onOpenSettings,
    required this.onOpenPremium,
  });

  final MainController controller;
  final Monetization monetization;
  final VoidCallback onOpenSettings;
  final VoidCallback onOpenPremium;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    return ListenableBuilder(
      listenable: Listenable.merge([controller, monetization]),
      builder: (context, _) => Scaffold(
        appBar: AppBar(
          title: const Text(AppInfo.name),
          actions: [
            PremiumAction(monetization: monetization, onPressed: onOpenPremium),
            IconButton(onPressed: onOpenSettings, icon: const Icon(Icons.settings), tooltip: l.settings),
          ],
        ),
        body: RefreshIndicator(
          onRefresh: controller.refresh,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            children: [
              _Filters(settings: controller.settings),
              const SizedBox(height: 12),
              ..._content(context),
              const SizedBox(height: 12),
              _Footer(controller.stations),
            ],
          ),
        ),
        bottomNavigationBar: AdBanner(monetization: monetization),
      ),
    );
  }

  List<Widget> _content(BuildContext context) {
    final l = L.of(context);
    final location = controller.location;
    return switch (location) {
      NeedsPermission() => [_ActionCard(l.locationPermission, l.allowLocation, controller.requestPermission)],
      LocationDisabled() => [_ActionCard(l.locationDisabled, l.openSettings, controller.openLocationSettings)],
      LocationUnavailable() => [_ActionCard(l.locationUnavailable, l.retry, controller.refresh)],
      Locating() => [_Loading(l.locating)],
      LocationReady() => switch (controller.stations) {
          StationsLoading() => [_Loading(l.loadingStations)],
          StationsFailed(:final network) => [_ActionCard(network ? l.errorNetwork : l.errorServer, l.retry, controller.refresh)],
          StationsReady() => _results(context),
        },
    };
  }

  List<Widget> _results(BuildContext context) {
    final l = L.of(context);
    final settings = controller.settings;
    final nearby = controller.nearby;
    if (nearby == null || nearby.stations.isEmpty) {
      return [Text(l.noStations(settings.radiusKm), style: Theme.of(context).textTheme.bodyLarge)];
    }
    return [
      _SummaryCard(nearby: nearby, settings: settings),
      const SizedBox(height: 12),
      LockedFeature(
        monetization: monetization,
        title: l.tripTitle,
        description: l.tripLocked,
        onGoPremium: onOpenPremium,
        child: _TripCard(nearby: nearby, litersPer100Km: settings.litersPer100Km, consumptionTenths: settings.consumptionTenths),
      ),
      for (final station in nearby.stations) ...[
        const SizedBox(height: 12),
        _StationCard(
          nearby: station,
          averagePrice: nearby.averagePrice,
          saving: nearby.savingVsAverage(station, settings.tankLiters),
          tankLiters: settings.tankLiters,
          onDirections: () => _openDirections(station.station),
        ),
      ],
    ];
  }

  /// Abre Mapas con la ruta hasta la gasolinera (Apple Maps en iOS, Google Maps en Android).
  Future<void> _openDirections(Station station) {
    final lat = station.latitude;
    final lon = station.longitude;
    final url = Platform.isIOS
        ? 'https://maps.apple.com/?daddr=$lat,$lon&dirflg=d'
        : 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lon';
    return openUrl(url);
  }
}

class _Filters extends StatelessWidget {
  const _Filters({required this.settings});

  final SettingsStore settings;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: 8, children: [
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(spacing: 8, children: [
          for (final fuel in Fuel.values)
            FilterChip(
              label: Text(fuelName(l, fuel)),
              selected: fuel == settings.fuel,
              onSelected: (_) => settings.setFuel(fuel),
            ),
        ]),
      ),
      Choice(
        options: [for (final km in SettingsStore.radiusOptions) (km, l.radiusKm(km))],
        selected: settings.radiusKm,
        onSelect: settings.setRadius,
      ),
      Choice(
        options: [(SortOrder.price, l.sortPrice), (SortOrder.distance, l.sortDistance)],
        selected: settings.sort,
        onSelect: settings.setSort,
      ),
    ]);
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.nearby, required this.settings});

  final NearbyResult nearby;
  final SettingsStore settings;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final locale = l.localeName;
    final average = nearby.averagePrice!;
    final cheapest = nearby.stations.reduce((a, b) => a.price <= b.price ? a : b);
    final saving = nearby.savingVsAverage(cheapest, settings.tankLiters);
    return ResultCard(children: [
      Text(l.summaryTitle(nearby.stations.length, settings.radiusKm), style: Theme.of(context).textTheme.titleMedium),
      Text(l.summaryAverage(formatPricePerLiter(locale, average))),
      Text(
        l.summaryCheapest(formatPricePerLiter(locale, cheapest.price), formatDistance(locale, cheapest.distanceKm)),
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      if (saving >= _minSavingEur)
        Text(l.summarySaving(formatEuros(saving, locale), settings.tankLiters), style: TextStyle(color: cheapColor(context))),
    ]);
  }
}

/// Función Premium: cuánto cuesta un viaje repostando en la más barata frente al precio medio.
class _TripCard extends StatefulWidget {
  const _TripCard({required this.nearby, required this.litersPer100Km, required this.consumptionTenths});

  final NearbyResult nearby;
  final double litersPer100Km;
  final int consumptionTenths;

  @override
  State<_TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<_TripCard> {
  String _km = '';

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final locale = l.localeName;
    final km = parseAmount(_km);
    final estimate = km == null ? null : TripCost.estimate(km, widget.litersPer100Km, widget.nearby);
    return ResultCard(children: [
      Text(l.tripTitle, style: Theme.of(context).textTheme.titleMedium),
      const SizedBox(height: 4),
      AmountField(value: _km, onChanged: (v) => setState(() => _km = v), label: l.tripDistance, suffix: 'km'),
      Note(l.tripConsumption(formatConsumption(locale, widget.consumptionTenths))),
      if (estimate != null) ...[
        Text(l.tripLiters(NumberFormat('0.0', locale).format(estimate.liters))),
        Text(l.tripCostCheapest(formatEuros(estimate.costAtCheapest, locale)), style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(l.tripCostAverage(formatEuros(estimate.costAtAverage, locale))),
        if (estimate.saving >= _minSavingEur)
          Text(l.tripSaving(formatEuros(estimate.saving, locale)), style: TextStyle(color: cheapColor(context))),
      ],
    ]);
  }
}

class _StationCard extends StatelessWidget {
  const _StationCard({
    required this.nearby,
    required this.averagePrice,
    required this.saving,
    required this.tankLiters,
    required this.onDirections,
  });

  final NearbyStation nearby;
  final double? averagePrice;
  final double saving;
  final int tankLiters;
  final VoidCallback onDirections;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final locale = l.localeName;
    final theme = Theme.of(context);
    final station = nearby.station;
    final average = averagePrice;
    final priceColor = average == null || nearby.price == average
        ? theme.colorScheme.onSurface
        : (nearby.price < average ? cheapColor(context) : expensiveColor(context));
    final muted = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 8, 4),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(station.brand.isEmpty ? l.unknownBrand : station.brand,
                    style: theme.textTheme.titleMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('${prettyCase(station.address)} · ${prettyCase(station.town)}',
                    style: muted, maxLines: 2, overflow: TextOverflow.ellipsis),
              ]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                Text(formatPricePerLiter(locale, nearby.price),
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: priceColor)),
                Text(formatDistance(locale, nearby.distanceKm), style: theme.textTheme.labelMedium),
              ]),
            ),
          ]),
          if (station.schedule.isNotEmpty)
            Padding(padding: const EdgeInsets.only(top: 4), child: Text(station.schedule, style: muted)),
          Row(children: [
            Expanded(
              child: saving >= _minSavingEur
                  ? Text(l.stationSaving(formatEuros(saving, locale), tankLiters),
                      style: theme.textTheme.labelMedium?.copyWith(color: cheapColor(context)))
                  : const SizedBox.shrink(),
            ),
            TextButton(onPressed: onDirections, child: Text(l.directions)),
          ]),
        ]),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(spacing: 12, children: [const CircularProgressIndicator(), Text(message)]),
    );
  }
}

class _ActionCard extends StatelessWidget {
  const _ActionCard(this.message, this.action, this.onAction);

  final String message;
  final String action;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    return ResultCard(children: [
      Text(message, style: Theme.of(context).textTheme.bodyLarge),
      const SizedBox(height: 6),
      FilledButton(onPressed: onAction, child: Text(action)),
    ]);
  }
}

class _Footer extends StatelessWidget {
  const _Footer(this.stations);

  final StationsState stations;

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    final theme = Theme.of(context);
    final muted = theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    final ready = stations is StationsReady ? stations as StationsReady : null;
    final updated = ready?.list.updatedAt;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (ready?.offline ?? false) Text(l.offlineData, style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.error)),
      if (updated != null) Text(l.updatedAt(DateFormat('dd/MM HH:mm').format(updated)), style: muted),
      Text(l.dataSource, style: muted),
    ]);
  }
}
