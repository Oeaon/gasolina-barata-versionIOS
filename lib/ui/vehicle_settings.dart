import 'package:flutter/material.dart';

import '../data/settings_store.dart';
import '../l10n/app_localizations.dart';
import 'components.dart';
import 'format.dart';
import 'settings_screen.dart';

/// Depósito y consumo del coche, en la parte de arriba de Ajustes.
class VehicleSettings extends StatefulWidget {
  const VehicleSettings({super.key, required this.settings});

  final SettingsStore settings;

  @override
  State<VehicleSettings> createState() => _VehicleSettingsState();
}

class _VehicleSettingsState extends State<VehicleSettings> {
  late double _liters = widget.settings.tankLiters.toDouble();
  late double _tenths = widget.settings.consumptionTenths.toDouble();

  @override
  Widget build(BuildContext context) {
    final l = L.of(context);
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SectionTitle(l.tankTitle),
      Text(l.tankLiters(_liters.round())),
      Slider(
        value: _liters,
        min: SettingsStore.minTank.toDouble(),
        max: SettingsStore.maxTank.toDouble(),
        divisions: (SettingsStore.maxTank - SettingsStore.minTank) ~/ 5,
        onChanged: (v) => setState(() => _liters = v),
        onChangeEnd: (v) => widget.settings.setTankLiters(v.round()),
      ),
      Note(l.tankDetail),
      const Divider(height: 32),
      SectionTitle(l.consumptionTitle),
      Text(l.consumptionValue(formatConsumption(l.localeName, _tenths.round()))),
      Slider(
        value: _tenths,
        min: SettingsStore.minConsumption.toDouble(),
        max: SettingsStore.maxConsumption.toDouble(),
        divisions: (SettingsStore.maxConsumption - SettingsStore.minConsumption) ~/ 5,
        onChanged: (v) => setState(() => _tenths = v),
        onChangeEnd: (v) => widget.settings.setConsumptionTenths(v.round()),
      ),
      Note(l.consumptionDetail),
    ]);
  }
}
