import 'package:flutter_test/flutter_test.dart';
import 'package:gasolina_barata/core/nearby_search.dart';
import 'package:gasolina_barata/core/station.dart';

// Los mismos casos que los tests de la versión Android (core/src/test).
void main() {
  group('búsqueda cercana', () {
    // Puerta del Sol, Madrid.
    const sunLat = 40.416775;
    const sunLon = -3.703790;

    Station station(String id, double lat, double lon, Map<Fuel, double> prices) => Station(
          id: id,
          brand: 'B$id',
          address: '',
          town: '',
          province: '',
          postalCode: '',
          latitude: lat,
          longitude: lon,
          schedule: '',
          prices: prices,
        );

    final stations = [
      station('cerca-cara', 40.4200, -3.7050, {Fuel.gasolina95: 1.60}),
      station('cerca-barata', 40.4300, -3.7000, {Fuel.gasolina95: 1.45}),
      station('media', 40.4500, -3.6900, {Fuel.gasolina95: 1.50, Fuel.diesel: 1.40}),
      station('toledo', 39.8628, -4.0273, {Fuel.gasolina95: 1.30}),
      station('solo-diesel', 40.4180, -3.7040, {Fuel.diesel: 1.35}),
    ];

    test('distancia conocida Madrid–Toledo', () {
      expect(NearbySearch.distanceKm(sunLat, sunLon, 39.8628, -4.0273), closeTo(67.5, 1.5));
    });

    test('filtra por radio y carburante y ordena por precio', () {
      final result = NearbySearch.find(stations, sunLat, sunLon, 10, Fuel.gasolina95, SortOrder.price);

      expect(result.stations.map((s) => s.station.id), ['cerca-barata', 'media', 'cerca-cara']);
      expect(result.cheapestPrice, closeTo(1.45, 1e-9));
      expect(result.averagePrice, closeTo((1.45 + 1.50 + 1.60) / 3, 1e-9));
    });

    test('ordena por distancia', () {
      final result = NearbySearch.find(stations, sunLat, sunLon, 10, Fuel.gasolina95, SortOrder.distance);

      expect(result.stations.map((s) => s.station.id), ['cerca-cara', 'cerca-barata', 'media']);
    });

    test('calcula el ahorro de un depósito frente a la media', () {
      final result = NearbySearch.find(stations, sunLat, sunLon, 10, Fuel.gasolina95, SortOrder.price);

      expect(result.savingVsAverage(result.stations.first, 50), closeTo((result.averagePrice! - 1.45) * 50, 1e-9));
    });

    test('sin gasolineras en el radio no hay media', () {
      final result = NearbySearch.find(stations, 43.0, -8.0, 5, Fuel.gasolina95, SortOrder.price);

      expect(result.stations, isEmpty);
      expect(result.averagePrice, isNull);
    });

    test('pone en minúsculas los textos del Ministerio', () {
      expect(prettyCase('AVENIDA DE LA CONSTITUCION, 26'), 'Avenida de la Constitucion, 26');
    });
  });

  group('lectura de la API', () {
    String station(String id, {String lat = '40,416775', String lon = '-3,703790', String gasolina95 = '1,479', String diesel = '1,379', String sale = 'P'}) =>
        '{"C.P.":"28013","Dirección":"CALLE MAYOR, 1","Horario":"L-D: 24H","Latitud":"$lat",'
        '"Localidad":"MADRID","Longitud (WGS84)":"$lon","Margen":"D","Municipio":"Madrid",'
        '"Precio Gasoleo A":"$diesel","Precio Gasoleo Premium":"","Precio Gasolina 95 E5":"$gasolina95",'
        '"Precio Gasolina 98 E5":"","Precio Gases licuados del petróleo":"","Provincia":"MADRID",'
        '"Remisión":"dm","Rótulo":"REPSOL","Tipo Venta":"$sale","IDEESS":"$id","IDMunicipio":"4354",'
        '"IDProvincia":"28","IDCCAA":"13"}';

    String response(List<String> stations) =>
        '{"Fecha":"13/10/2026 17:20:31","ListaEESSPrecio":[${stations.join(',')}],"Nota":"","ResultadoConsulta":"OK"}';

    test('lee decimales con coma y la fecha de actualización', () {
      final list = StationParser.parse(response([station('1')]));

      expect(list.updatedAt, DateTime(2026, 10, 13, 17, 20, 31));
      final parsed = list.stations.single;
      expect(parsed.brand, 'REPSOL');
      expect(parsed.latitude, closeTo(40.416775, 1e-9));
      expect(parsed.longitude, closeTo(-3.70379, 1e-9));
      expect(parsed.prices[Fuel.gasolina95], closeTo(1.479, 1e-9));
      expect(parsed.prices[Fuel.diesel], closeTo(1.379, 1e-9));
    });

    test('los precios vacíos no se guardan', () {
      final parsed = StationParser.parse(response([station('1', diesel: '')])).stations.single;

      expect(parsed.prices.containsKey(Fuel.diesel), isFalse);
      expect(parsed.prices.containsKey(Fuel.glp), isFalse);
    });

    test('descarta venta restringida, sin coordenadas y sin precios', () {
      final list = StationParser.parse(response([
        station('1', sale: 'R'),
        station('2', lat: ''),
        station('3', gasolina95: '', diesel: ''),
        station('4'),
      ]));

      expect(list.stations.map((s) => s.id), ['4']);
    });

    test('una fecha rara no impide leer las gasolineras', () {
      final list = StationParser.parse(response([station('1')]).replaceAll('13/10/2026 17:20:31', 'ayer'));

      expect(list.updatedAt, isNull);
      expect(list.stations, hasLength(1));
    });

    test('sin lista de gasolineras lanza StationFormatException', () {
      expect(() => StationParser.parse('{"ResultadoConsulta":"ERROR"}'), throwsA(isA<StationFormatException>()));
    });
  });

  group('viaje', () {
    NearbyResult nearby(List<double> prices) => NearbyResult([
          for (var i = 0; i < prices.length; i++)
            NearbyStation(
              Station(id: '$i', brand: '', address: '', town: '', province: '', postalCode: '', latitude: 0, longitude: 0, schedule: '', prices: {Fuel.diesel: prices[i]}),
              i.toDouble(),
              prices[i],
            ),
        ]);

    test('calcula litros y coste en la más barata y a precio medio', () {
      final estimate = TripCost.estimate(500, 6, nearby([1.40, 1.50, 1.60]))!;

      expect(estimate.liters, closeTo(30, 1e-9));
      expect(estimate.costAtCheapest, closeTo(42, 1e-9));
      expect(estimate.costAtAverage, closeTo(45, 1e-9));
      expect(estimate.saving, closeTo(3, 1e-9));
    });

    test('sin distancia o sin gasolineras no hay estimación', () {
      expect(TripCost.estimate(0, 6, nearby([1.4])), isNull);
      expect(TripCost.estimate(100, 6, nearby([])), isNull);
    });
  });
}
