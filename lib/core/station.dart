import 'dart:convert';

/// Carburantes que se muestran, con su campo en la API del Ministerio.
enum Fuel {
  gasolina95('Precio Gasolina 95 E5'),
  gasolina98('Precio Gasolina 98 E5'),
  diesel('Precio Gasoleo A'),
  dieselPremium('Precio Gasoleo Premium'),
  glp('Precio Gases licuados del petróleo');

  const Fuel(this.jsonKey);

  final String jsonKey;
}

/// Gasolinera de venta al público. Los precios están en €/litro con impuestos.
class Station {
  const Station({
    required this.id,
    required this.brand,
    required this.address,
    required this.town,
    required this.province,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.schedule,
    required this.prices,
  });

  final String id;
  final String brand;
  final String address;
  final String town;
  final String province;
  final String postalCode;
  final double latitude;
  final double longitude;
  final String schedule;
  final Map<Fuel, double> prices;
}

class StationList {
  const StationList(this.updatedAt, this.stations);

  /// Hora oficial de los precios según el Ministerio (hora peninsular).
  final DateTime? updatedAt;
  final List<Station> stations;
}

class StationFormatException implements Exception {
  const StationFormatException(this.message);

  final String message;

  @override
  String toString() => 'StationFormatException: $message';
}

/// Lee la respuesta de `EstacionesTerrestres` del Ministerio para la Transición Ecológica.
/// Todos los valores llegan como texto y los decimales con coma ("1,459").
/// Se descartan las gasolineras de venta restringida y las que no tienen coordenadas.
class StationParser {
  StationParser._();

  static const _restrictedSale = 'R';

  static StationList parse(String body) {
    final Object? root;
    try {
      root = jsonDecode(body);
    } on FormatException {
      throw const StationFormatException('Respuesta no es JSON');
    }
    if (root is! Map<String, dynamic>) throw const StationFormatException('Respuesta no es un objeto JSON');
    final list = root['ListaEESSPrecio'];
    if (list is! List) throw const StationFormatException('Falta ListaEESSPrecio');
    final stations = [
      for (final item in list)
        if (item is Map<String, dynamic>)
          ?_toStation(item),
    ];
    return StationList(_parseDate(_text(root, 'Fecha')), stations);
  }

  static Station? _toStation(Map<String, dynamic> json) {
    if (_text(json, 'Tipo Venta') == _restrictedSale) return null;
    final id = _text(json, 'IDEESS');
    final latitude = _decimal(json, 'Latitud');
    final longitude = _decimal(json, 'Longitud (WGS84)');
    if (id == null || latitude == null || longitude == null) return null;
    final prices = <Fuel, double>{
      for (final fuel in Fuel.values)
        if (_decimal(json, fuel.jsonKey) case final price? when price > 0) fuel: price,
    };
    if (prices.isEmpty) return null;
    return Station(
      id: id,
      brand: _text(json, 'Rótulo') ?? '',
      address: _text(json, 'Dirección') ?? '',
      town: _text(json, 'Localidad') ?? '',
      province: _text(json, 'Provincia') ?? '',
      postalCode: _text(json, 'C.P.') ?? '',
      latitude: latitude,
      longitude: longitude,
      schedule: _text(json, 'Horario') ?? '',
      prices: prices,
    );
  }

  static String? _text(Map<String, dynamic> json, String key) {
    final value = json[key];
    if (value is! String) return null;
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  static double? _decimal(Map<String, dynamic> json, String key) => double.tryParse(_text(json, key)?.replaceAll(',', '.') ?? '');

  /// "13/10/2026 17:20:31" → fecha; cualquier otra cosa → null.
  static DateTime? _parseDate(String? text) {
    final m = RegExp(r'^(\d{1,2})/(\d{1,2})/(\d{4}) (\d{1,2}):(\d{2}):(\d{2})$').firstMatch(text ?? '');
    if (m == null) return null;
    final n = [for (var i = 1; i <= 6; i++) int.parse(m.group(i)!)];
    return DateTime(n[2], n[1], n[0], n[3], n[4], n[5]);
  }
}

const _lowercaseWords = {'de', 'del', 'la', 'las', 'el', 'los', 'y', 'a', 'en'};

/// "AVENIDA DE LA CONSTITUCION, 26" → "Avenida de la Constitucion, 26". El Ministerio lo da todo en mayúsculas.
String prettyCase(String text) {
  final words = text.toLowerCase().split(' ');
  return [
    for (var i = 0; i < words.length; i++)
      i > 0 && _lowercaseWords.contains(words[i]) || words[i].isEmpty ? words[i] : words[i][0].toUpperCase() + words[i].substring(1),
  ].join(' ');
}
