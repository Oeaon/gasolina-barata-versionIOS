import 'package:flutter/widgets.dart';

import '../core/nearby_search.dart';
import '../core/station.dart';
import '../data/location.dart';
import '../data/settings_store.dart';
import '../data/stations_repository.dart';

sealed class StationsState {
  const StationsState();
}

class StationsLoading extends StationsState {
  const StationsLoading();
}

class StationsReady extends StationsState {
  const StationsReady(this.list, {required this.offline});

  final StationList list;
  final bool offline;
}

class StationsFailed extends StationsState {
  const StationsFailed({required this.network});

  final bool network;
}

/// Ubicación, gasolineras y búsqueda cercana. Recalcula al cambiar los ajustes.
class MainController extends ChangeNotifier with WidgetsBindingObserver {
  MainController(this.settings, this._stations, this._location) {
    settings.addListener(_search);
    WidgetsBinding.instance.addObserver(this);
    _loadStations(refresh: false);
    locate();
  }

  final SettingsStore settings;
  final StationsRepository _stations;
  final LocationProvider _location;

  LocationState location = const Locating();
  StationsState stations = const StationsLoading();
  NearbyResult? nearby;
  int _locateRun = 0;

  /// Al volver a la app: puede que haya dado el permiso o activado la ubicación en Ajustes.
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && (location is NeedsPermission || location is LocationDisabled)) locate();
  }

  Future<void> locate({bool askPermission = false}) async {
    final run = ++_locateRun;
    if (location is! LocationReady) {
      location = const Locating();
      notifyListeners();
    }
    final result = await _location.current(askPermission: askPermission);
    if (run != _locateRun) return;
    location = result;
    _search();
  }

  Future<void> refresh() => Future.wait([locate(), _loadStations(refresh: true)]);

  Future<void> requestPermission() async {
    final current = location;
    if (current is NeedsPermission && current.permanentlyDenied) {
      await _location.openAppSettings();
    } else {
      await locate(askPermission: true);
    }
  }

  Future<void> openLocationSettings() => _location.openLocationSettings();

  Future<void> _loadStations({required bool refresh}) async {
    final result = await _stations.stations(refresh: refresh);
    final next = switch (result) {
      StationsAvailable(:final list, :final offline) => StationsReady(list, offline: offline),
      StationsNetworkError() => const StationsFailed(network: true),
      StationsServerError() => const StationsFailed(network: false),
    };
    // Si falla una actualización manual pero ya había datos, se mantienen.
    if (refresh && next is! StationsReady && stations is StationsReady) return;
    stations = next;
    _search();
  }

  /// Recalcula las gasolineras cercanas (filtrar ~12.000 tarda milisegundos).
  void _search() {
    final here = location;
    final list = stations;
    nearby = here is LocationReady && list is StationsReady
        ? NearbySearch.find(list.list.stations, here.latitude, here.longitude, settings.radiusKm.toDouble(), settings.fuel, settings.sort)
        : null;
    notifyListeners();
  }

  @override
  void dispose() {
    settings.removeListener(_search);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
