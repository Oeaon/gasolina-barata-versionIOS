// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class LEs extends L {
  LEs([String locale = 'es']) : super(locale);

  @override
  String get settings => 'Ajustes';

  @override
  String get back => 'Volver';

  @override
  String get retry => 'Reintentar';

  @override
  String get fuelGasolina95 => 'Gasolina 95';

  @override
  String get fuelGasolina98 => 'Gasolina 98';

  @override
  String get fuelDiesel => 'Diésel';

  @override
  String get fuelDieselPremium => 'Diésel Premium';

  @override
  String get fuelGlp => 'GLP';

  @override
  String radiusKm(int p1) {
    return '$p1 km';
  }

  @override
  String get sortPrice => 'Precio';

  @override
  String get sortDistance => 'Distancia';

  @override
  String get locationPermission =>
      'Para buscar las gasolineras más baratas cerca de ti necesitamos tu ubicación. Solo se usa en el móvil y no se envía a ningún sitio.';

  @override
  String get allowLocation => 'Permitir ubicación';

  @override
  String get locationDisabled => 'La ubicación del móvil está desactivada.';

  @override
  String get openSettings => 'Activar ubicación';

  @override
  String get locationUnavailable =>
      'No hemos podido saber dónde estás. Prueba otra vez en un sitio con mejor señal.';

  @override
  String get locating => 'Buscando tu ubicación…';

  @override
  String get loadingStations => 'Descargando precios oficiales…';

  @override
  String get errorNetwork =>
      'No hay conexión. Comprueba tu internet e inténtalo de nuevo.';

  @override
  String get errorServer =>
      'No se han podido cargar los precios. Inténtalo dentro de un rato.';

  @override
  String noStations(int p1) {
    return 'No hay gasolineras con este carburante a menos de $p1 km.';
  }

  @override
  String summaryTitle(int p1, int p2) {
    return '$p1 gasolineras a menos de $p2 km';
  }

  @override
  String summaryAverage(String p1) {
    return 'Precio medio: $p1';
  }

  @override
  String summaryCheapest(String p1, String p2) {
    return 'La más barata: $p1 a $p2';
  }

  @override
  String summarySaving(String p1, int p2) {
    return 'Llenando $p2 L ahorras $p1 frente a la media';
  }

  @override
  String stationSaving(String p1, int p2) {
    return 'Ahorras $p1 en $p2 L';
  }

  @override
  String get unknownBrand => 'Gasolinera';

  @override
  String get directions => 'Cómo llegar';

  @override
  String get offlineData =>
      'Sin conexión: precios guardados de la última consulta.';

  @override
  String updatedAt(String p1) {
    return 'Precios del $p1';
  }

  @override
  String get dataSource =>
      'Precios oficiales con impuestos. Datos: Ministerio para la Transición Ecológica y el Reto Demográfico.';

  @override
  String get tankTitle => 'Depósito';

  @override
  String tankLiters(int p1) {
    return '$p1 litros';
  }

  @override
  String get tankDetail => 'Se usa para calcular cuánto ahorras al llenar.';

  @override
  String get privacyOptions => 'Opciones de privacidad de anuncios';

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get aboutText =>
      'Precios de las gasolineras de España publicados por el Ministerio para la Transición Ecológica y el Reto Demográfico, que se actualizan cada 30 minutos. El precio final lo marca siempre el surtidor.';

  @override
  String get sourceTitle => 'Fuente de los datos';

  @override
  String get sourceGeoportal => 'Geoportal de Gasolineras (Ministerio)';

  @override
  String get sourceService =>
      'Servicio oficial de precios de carburantes (minetur.gob.es)';

  @override
  String get aboutDisclaimer =>
      'Gasolina Barata es una app independiente y no está vinculada al Ministerio ni a ningún organismo público.';

  @override
  String version(String p1) {
    return 'Versión $p1';
  }

  @override
  String get tripTitle => '¿Cuánto me cuesta el viaje?';

  @override
  String get tripLocked =>
      'Calcula el combustible y lo que te cuesta un viaje repostando en la gasolinera más barata.';

  @override
  String get tripDistance => 'Distancia del viaje';

  @override
  String tripConsumption(String p1) {
    return 'Con un consumo de $p1 l/100 km (cámbialo en Ajustes)';
  }

  @override
  String tripLiters(String p1) {
    return 'Necesitas $p1 litros';
  }

  @override
  String tripCostCheapest(String p1) {
    return 'En la más barata: $p1';
  }

  @override
  String tripCostAverage(String p1) {
    return 'A precio medio: $p1';
  }

  @override
  String tripSaving(String p1) {
    return 'Te ahorras $p1 en el viaje';
  }

  @override
  String get consumptionTitle => 'Consumo del coche';

  @override
  String consumptionValue(String p1) {
    return '$p1 l/100 km';
  }

  @override
  String get consumptionDetail => 'Se usa en la calculadora de viajes.';

  @override
  String get premiumFeatureTrip => 'Calculadora del coste de un viaje';

  @override
  String get premiumSettingsText =>
      'Quita los anuncios y desbloquea la calculadora de viajes.';

  @override
  String get removeAds => 'Quitar anuncios';

  @override
  String get premiumTitle => 'Premium';

  @override
  String get premiumBack => 'Volver';

  @override
  String get premiumHeadline => 'Pásate a Premium';

  @override
  String get premiumActive => 'Ya eres Premium. ¡Gracias por tu apoyo!';

  @override
  String get premiumBenefitNoAds => 'Sin anuncios';

  @override
  String premiumMonthly(String p1) {
    return '$p1 al mes';
  }

  @override
  String premiumLifetime(String p1) {
    return '$p1, pago único para siempre';
  }

  @override
  String get premiumLoading => 'Cargando precio…';

  @override
  String get premiumStoreUnavailable =>
      'No se puede conectar con el App Store. Inténtalo más tarde.';

  @override
  String get premiumRestore => 'Restaurar compras';

  @override
  String get premiumLegal =>
      'La suscripción se renueva cada mes y puedes cancelarla cuando quieras en el App Store.';

  @override
  String get lockedWatchAd => 'Ver un anuncio y desbloquear 24 h';

  @override
  String get lockedGoPremium => 'Hazte Premium';

  @override
  String get rewardedUnavailable =>
      'No hay ningún anuncio disponible ahora mismo. Prueba dentro de un rato.';

  @override
  String get privacyPolicy => 'Política de privacidad';

  @override
  String get termsOfUse => 'Términos de uso';
}
