import 'package:geolocator/geolocator.dart';

sealed class LocationState {
  const LocationState();
}

class Locating extends LocationState {
  const Locating();
}

class NeedsPermission extends LocationState {
  const NeedsPermission({required this.permanentlyDenied});

  /// En iOS, tras el primer "No permitir" solo se puede cambiar en Ajustes.
  final bool permanentlyDenied;
}

class LocationDisabled extends LocationState {
  const LocationDisabled();
}

class LocationUnavailable extends LocationState {
  const LocationUnavailable();
}

class LocationReady extends LocationState {
  const LocationReady(this.latitude, this.longitude);

  final double latitude;
  final double longitude;
}

class LocationProvider {
  static const _recent = Duration(minutes: 10);

  /// Solo para las capturas de la tienda (`--dart-define=SCREENSHOTS=true`): una posición fija en Madrid.
  static const _screenshots = bool.fromEnvironment('SCREENSHOTS');

  Future<LocationState> current({bool askPermission = false}) async {
    if (_screenshots) return const LocationReady(40.4168, -3.7038);
    if (!await Geolocator.isLocationServiceEnabled()) return const LocationDisabled();
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied && askPermission) permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) return const NeedsPermission(permanentlyDenied: false);
    if (permission == LocationPermission.deniedForever) return const NeedsPermission(permanentlyDenied: true);

    // Una posición reciente si la hay; si no, se pide una nueva.
    final last = await Geolocator.getLastKnownPosition();
    if (last != null && DateTime.now().difference(last.timestamp) < _recent) {
      return LocationReady(last.latitude, last.longitude);
    }
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.medium, timeLimit: Duration(seconds: 15)),
      );
      return LocationReady(position.latitude, position.longitude);
    } on Exception {
      return last != null ? LocationReady(last.latitude, last.longitude) : const LocationUnavailable();
    }
  }

  Future<void> openAppSettings() => Geolocator.openAppSettings();

  Future<void> openLocationSettings() => Geolocator.openLocationSettings();
}
