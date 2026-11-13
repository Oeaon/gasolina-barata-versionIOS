// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Galician (`gl`).
class LGl extends L {
  LGl([String locale = 'gl']) : super(locale);

  @override
  String get settings => 'Axustes';

  @override
  String get back => 'Volver';

  @override
  String get retry => 'Tentar de novo';

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
  String get sortPrice => 'Prezo';

  @override
  String get sortDistance => 'Distancia';

  @override
  String get locationPermission =>
      'Para buscar as gasolineiras máis baratas preto de ti necesitamos a túa localización. Só se usa no móbil e non se envía a ningures.';

  @override
  String get allowLocation => 'Permitir localización';

  @override
  String get locationDisabled => 'A localización do móbil está desactivada.';

  @override
  String get openSettings => 'Activar localización';

  @override
  String get locationUnavailable =>
      'Non puidemos saber onde estás. Proba outra vez nun sitio con mellor cobertura.';

  @override
  String get locating => 'Buscando a túa localización…';

  @override
  String get loadingStations => 'Descargando os prezos oficiais…';

  @override
  String get errorNetwork =>
      'Non hai conexión. Comproba a túa conexión e téntao de novo.';

  @override
  String get errorServer =>
      'Non se puideron cargar os prezos. Téntao dentro dun anaco.';

  @override
  String noStations(int p1) {
    return 'Non hai gasolineiras con este carburante a menos de $p1 km.';
  }

  @override
  String summaryTitle(int p1, int p2) {
    return '$p1 gasolineiras a menos de $p2 km';
  }

  @override
  String summaryAverage(String p1) {
    return 'Prezo medio: $p1';
  }

  @override
  String summaryCheapest(String p1, String p2) {
    return 'A máis barata: $p1 a $p2';
  }

  @override
  String summarySaving(String p1, int p2) {
    return 'Enchendo $p2 L aforras $p1 fronte á media';
  }

  @override
  String stationSaving(String p1, int p2) {
    return 'Aforras $p1 en $p2 L';
  }

  @override
  String get unknownBrand => 'Gasolineira';

  @override
  String get directions => 'Como chegar';

  @override
  String get offlineData => 'Sen conexión: prezos gardados da última consulta.';

  @override
  String updatedAt(String p1) {
    return 'Prezos do $p1';
  }

  @override
  String get dataSource =>
      'Prezos oficiais con impostos. Datos: Ministerio para a Transición Ecolóxica e o Reto Demográfico.';

  @override
  String get tankTitle => 'Depósito';

  @override
  String tankLiters(int p1) {
    return '$p1 litros';
  }

  @override
  String get tankDetail => 'Úsase para calcular canto aforras ao encher.';

  @override
  String get privacyOptions => 'Opcións de privacidade dos anuncios';

  @override
  String get aboutTitle => 'Acerca de';

  @override
  String get aboutText =>
      'Prezos das gasolineiras de España publicados polo Ministerio para a Transición Ecolóxica e o Reto Demográfico, que se actualizan cada 30 minutos. O prezo final sempre é o do surtidor.';

  @override
  String get sourceTitle => 'Fonte dos datos';

  @override
  String get sourceGeoportal => 'Xeoportal de Gasolineiras (Ministerio)';

  @override
  String get sourceService =>
      'Servizo oficial de prezos de carburantes (minetur.gob.es)';

  @override
  String get aboutDisclaimer =>
      'Gasolina Barata é unha app independente e non está vinculada ao Ministerio nin a ningún organismo público.';

  @override
  String version(String p1) {
    return 'Versión $p1';
  }

  @override
  String get tripTitle => 'Canto me custa a viaxe?';

  @override
  String get tripLocked =>
      'Calcula o combustible e o que che custa unha viaxe repostando na gasolineira máis barata.';

  @override
  String get tripDistance => 'Distancia da viaxe';

  @override
  String tripConsumption(String p1) {
    return 'Cun consumo de $p1 l/100 km (cámbiao en Axustes)';
  }

  @override
  String tripLiters(String p1) {
    return 'Necesitas $p1 litros';
  }

  @override
  String tripCostCheapest(String p1) {
    return 'Na máis barata: $p1';
  }

  @override
  String tripCostAverage(String p1) {
    return 'A prezo medio: $p1';
  }

  @override
  String tripSaving(String p1) {
    return 'Aforras $p1 na viaxe';
  }

  @override
  String get consumptionTitle => 'Consumo do coche';

  @override
  String consumptionValue(String p1) {
    return '$p1 l/100 km';
  }

  @override
  String get consumptionDetail => 'Úsase na calculadora de viaxes.';

  @override
  String get premiumFeatureTrip => 'Calculadora do custo dunha viaxe';

  @override
  String get premiumSettingsText =>
      'Quita os anuncios e desbloquea a calculadora de viaxes.';

  @override
  String get removeAds => 'Quitar anuncios';

  @override
  String get premiumTitle => 'Premium';

  @override
  String get premiumBack => 'Volver';

  @override
  String get premiumHeadline => 'Pásate a Premium';

  @override
  String get premiumActive => 'Xa es Premium. Grazas polo teu apoio!';

  @override
  String get premiumBenefitNoAds => 'Sen anuncios';

  @override
  String premiumMonthly(String p1) {
    return '$p1 ao mes';
  }

  @override
  String premiumLifetime(String p1) {
    return '$p1, pagamento único para sempre';
  }

  @override
  String get premiumLoading => 'Cargando o prezo…';

  @override
  String get premiumStoreUnavailable =>
      'Non se pode conectar coa App Store. Téntao máis tarde.';

  @override
  String get premiumRestore => 'Restaurar compras';

  @override
  String get premiumLegal =>
      'A subscrición renóvase cada mes e podes cancelala cando queiras na App Store.';

  @override
  String get lockedWatchAd => 'Ver un anuncio e desbloquear 24 h';

  @override
  String get lockedGoPremium => 'Faite Premium';

  @override
  String get rewardedUnavailable =>
      'Agora mesmo non hai ningún anuncio dispoñible. Proba dentro dun anaco.';

  @override
  String get privacyPolicy => 'Política de privacidade';

  @override
  String get termsOfUse => 'Termos de uso';
}
