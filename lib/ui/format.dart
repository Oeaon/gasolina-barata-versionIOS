import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/station.dart';
import '../l10n/app_localizations.dart';

String formatPricePerLiter(String locale, double eur) => '${NumberFormat('0.000', locale).format(eur)} €/L';

String formatDistance(String locale, double km) =>
    km < 1 ? '${NumberFormat('0', locale).format(km * 1000)} m' : '${NumberFormat('0.0', locale).format(km)} km';

/// Consumo guardado en décimas: 65 → "6,5".
String formatConsumption(String locale, int tenths) => NumberFormat('0.0', locale).format(tenths / 10);

String fuelName(L l, Fuel fuel) => switch (fuel) {
      Fuel.gasolina95 => l.fuelGasolina95,
      Fuel.gasolina98 => l.fuelGasolina98,
      Fuel.diesel => l.fuelDiesel,
      Fuel.dieselPremium => l.fuelDieselPremium,
      Fuel.glp => l.fuelGlp,
    };

Color cheapColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark ? const Color(0xFF81C784) : const Color(0xFF2E7D32);

Color expensiveColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark ? const Color(0xFFE57373) : const Color(0xFFC62828);
