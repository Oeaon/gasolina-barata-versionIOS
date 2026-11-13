import 'dart:math';

import 'station.dart';

enum SortOrder { price, distance }

class NearbyStation {
  const NearbyStation(this.station, this.distanceKm, this.price);

  final Station station;
  final double distanceKm;
  final double price;
}

class NearbyResult {
  NearbyResult(this.stations)
      : averagePrice = stations.isEmpty ? null : stations.map((s) => s.price).reduce((a, b) => a + b) / stations.length,
        cheapestPrice = stations.isEmpty ? null : stations.map((s) => s.price).reduce(min);

  final List<NearbyStation> stations;
  final double? averagePrice;
  final double? cheapestPrice;

  /// Euros que se ahorran llenando [liters] litros aquí frente a la media de la zona.
  double savingVsAverage(NearbyStation station, int liters) =>
      averagePrice == null ? 0 : (averagePrice! - station.price) * liters;
}

class NearbySearch {
  NearbySearch._();

  static const _earthRadiusKm = 6371.0;
  static const _kmPerDegree = 111.32;

  static NearbyResult find(
    List<Station> stations,
    double latitude,
    double longitude,
    double radiusKm,
    Fuel fuel,
    SortOrder sort,
  ) {
    // Caja previa en grados para no calcular la distancia exacta de las ~12.000 gasolineras.
    final latDelta = radiusKm / _kmPerDegree;
    final lonDelta = radiusKm / (_kmPerDegree * max(cos(_rad(latitude)), 0.01));
    final nearby = <NearbyStation>[];
    for (final station in stations) {
      if ((station.latitude - latitude).abs() > latDelta || (station.longitude - longitude).abs() > lonDelta) continue;
      final price = station.prices[fuel];
      if (price == null) continue;
      final distance = distanceKm(latitude, longitude, station.latitude, station.longitude);
      if (distance <= radiusKm) nearby.add(NearbyStation(station, distance, price));
    }
    switch (sort) {
      case SortOrder.price:
        nearby.sort((a, b) {
          final byPrice = a.price.compareTo(b.price);
          return byPrice != 0 ? byPrice : a.distanceKm.compareTo(b.distanceKm);
        });
      case SortOrder.distance:
        nearby.sort((a, b) => a.distanceKm.compareTo(b.distanceKm));
    }
    return NearbyResult(nearby);
  }

  /// Distancia en línea recta (fórmula del semiverseno).
  static double distanceKm(double lat1, double lon1, double lat2, double lon2) {
    final dLat = _rad(lat2 - lat1);
    final dLon = _rad(lon2 - lon1);
    final a = pow(sin(dLat / 2), 2) + cos(_rad(lat1)) * cos(_rad(lat2)) * pow(sin(dLon / 2), 2);
    return 2 * _earthRadiusKm * asin(sqrt(a));
  }

  static double _rad(double degrees) => degrees * pi / 180;
}

class TripEstimate {
  const TripEstimate(this.liters, this.costAtCheapest, this.costAtAverage);

  final double liters;
  final double costAtCheapest;
  final double costAtAverage;

  double get saving => costAtAverage - costAtCheapest;
}

class TripCost {
  TripCost._();

  /// Coste de un viaje de [distanceKm] con un consumo de [litersPer100Km], repostando en la más barata o a precio medio.
  static TripEstimate? estimate(double distanceKm, double litersPer100Km, NearbyResult nearby) {
    if (distanceKm <= 0 || litersPer100Km <= 0) return null;
    final cheapest = nearby.cheapestPrice;
    final average = nearby.averagePrice;
    if (cheapest == null || average == null) return null;
    final liters = distanceKm * litersPer100Km / 100;
    return TripEstimate(liters, liters * cheapest, liters * average);
  }
}
