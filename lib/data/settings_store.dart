import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/nearby_search.dart';
import '../core/station.dart';

/// Carburante, radio, orden, depósito y consumo del coche.
class SettingsStore extends ChangeNotifier {
  SettingsStore._(this._prefs);

  static const radiusOptions = [5, 10, 25];
  static const minTank = 20;
  static const maxTank = 100;
  static const minConsumption = 30;
  static const maxConsumption = 150;

  final SharedPreferences _prefs;

  static Future<SettingsStore> open() async => SettingsStore._(await SharedPreferences.getInstance());

  Fuel get fuel => Fuel.values.firstWhere((f) => f.name == _prefs.getString('fuel'), orElse: () => Fuel.gasolina95);

  int get radiusKm {
    final value = _prefs.getInt('radius_km');
    return radiusOptions.contains(value) ? value! : 10;
  }

  SortOrder get sort => SortOrder.values.firstWhere((s) => s.name == _prefs.getString('sort'), orElse: () => SortOrder.price);

  /// Litros de un depósito, para calcular el ahorro.
  int get tankLiters => (_prefs.getInt('tank_liters') ?? 50).clamp(minTank, maxTank);

  /// Consumo del coche en décimas de l/100 km, para la calculadora de viajes.
  int get consumptionTenths => (_prefs.getInt('consumption_tenths') ?? 65).clamp(minConsumption, maxConsumption);

  double get litersPer100Km => consumptionTenths / 10;

  Future<void> setFuel(Fuel value) => _set(() => _prefs.setString('fuel', value.name));

  Future<void> setRadius(int km) => _set(() => _prefs.setInt('radius_km', km));

  Future<void> setSort(SortOrder value) => _set(() => _prefs.setString('sort', value.name));

  Future<void> setTankLiters(int liters) => _set(() => _prefs.setInt('tank_liters', liters.clamp(minTank, maxTank)));

  Future<void> setConsumptionTenths(int tenths) =>
      _set(() => _prefs.setInt('consumption_tenths', tenths.clamp(minConsumption, maxConsumption)));

  Future<void> _set(Future<bool> Function() write) async {
    await write();
    notifyListeners();
  }
}
