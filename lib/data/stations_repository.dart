import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:path_provider/path_provider.dart';

import '../core/station.dart';

sealed class StationsResult {
  const StationsResult();
}

/// [offline] = no se pudo actualizar y se muestran los datos guardados.
class StationsAvailable extends StationsResult {
  const StationsAvailable(this.list, {required this.offline});

  final StationList list;
  final bool offline;
}

class StationsNetworkError extends StationsResult {
  const StationsNetworkError();
}

class StationsServerError extends StationsResult {
  const StationsServerError();
}

/// Precios oficiales del Ministerio para la Transición Ecológica (sin clave, se actualizan cada 30 min),
/// con la última lista guardada en disco para abrir rápido y funcionar sin conexión.
class StationsRepository {
  StationsRepository({http.Client? client})
      : _client = client ?? IOClient(HttpClient()..connectionTimeout = const Duration(seconds: 15));

  static const _url = 'https://sedeaplicaciones.minetur.gob.es/ServiciosRESTCarburantes/PreciosCarburantes/EstacionesTerrestres/';
  static const _maxAge = Duration(minutes: 30);

  /// Son unos 12 MB sin comprimir: con mala cobertura tardan bastante más que en wifi.
  static const _downloadLimit = Duration(minutes: 2);

  final http.Client _client;
  (StationList, DateTime)? _memory;
  Future<StationsResult>? _running;

  /// Las llamadas simultáneas comparten la misma descarga.
  Future<StationsResult> stations({bool refresh = false}) => _running ??= _load(refresh).whenComplete(() => _running = null);

  Future<StationsResult> _load(bool refresh) async {
    final loaded = _memory ??= await _readCache();
    if (loaded != null && !refresh && DateTime.now().difference(loaded.$2) < _maxAge) {
      return StationsAvailable(loaded.$1, offline: false);
    }
    StationsResult fallback(StationsResult error) => loaded != null ? StationsAvailable(loaded.$1, offline: true) : error;

    final http.Response response;
    try {
      response = await _client.get(Uri.parse(_url), headers: {'Accept': 'application/json'}).timeout(_downloadLimit);
    } on Exception {
      return fallback(const StationsNetworkError());
    }
    if (response.statusCode != 200) return fallback(const StationsServerError());
    final body = response.body;
    final list = await _parse(body);
    if (list == null || list.stations.isEmpty) return fallback(const StationsServerError());
    await _writeCache(body);
    _memory = (list, DateTime.now());
    return StationsAvailable(list, offline: false);
  }

  /// Leer las ~12.000 gasolineras fuera del hilo de la interfaz.
  static Future<StationList?> _parse(String body) => compute(_parseOrNull, body);

  static StationList? _parseOrNull(String body) {
    try {
      return StationParser.parse(body);
    } on StationFormatException {
      return null;
    }
  }

  Future<File> _cacheFile() async => File('${(await getApplicationSupportDirectory()).path}/stations.json');

  Future<(StationList, DateTime)?> _readCache() async {
    try {
      final file = await _cacheFile();
      if (!await file.exists()) return null;
      final list = await _parse(await file.readAsString());
      return list == null ? null : (list, await file.lastModified());
    } on IOException {
      return null;
    }
  }

  Future<void> _writeCache(String body) async {
    try {
      final file = await _cacheFile();
      final tmp = File('${file.path}.tmp');
      await tmp.writeAsString(body, flush: true);
      await tmp.rename(file.path);
    } on IOException {
      // Sin caché la app sigue funcionando; solo vuelve a descargar.
    }
  }
}
