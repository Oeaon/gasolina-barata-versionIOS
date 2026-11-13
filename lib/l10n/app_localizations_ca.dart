// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class LCa extends L {
  LCa([String locale = 'ca']) : super(locale);

  @override
  String get settings => 'Configuració';

  @override
  String get back => 'Tornar';

  @override
  String get retry => 'Torna-ho a provar';

  @override
  String get fuelGasolina95 => 'Gasolina 95';

  @override
  String get fuelGasolina98 => 'Gasolina 98';

  @override
  String get fuelDiesel => 'Dièsel';

  @override
  String get fuelDieselPremium => 'Dièsel Premium';

  @override
  String get fuelGlp => 'GLP';

  @override
  String radiusKm(int p1) {
    return '$p1 km';
  }

  @override
  String get sortPrice => 'Preu';

  @override
  String get sortDistance => 'Distància';

  @override
  String get locationPermission =>
      'Per buscar les benzineres més barates a prop teu necessitem la teva ubicació. Només s\'utilitza al mòbil i no s\'envia enlloc.';

  @override
  String get allowLocation => 'Permet la ubicació';

  @override
  String get locationDisabled => 'La ubicació del mòbil està desactivada.';

  @override
  String get openSettings => 'Activa la ubicació';

  @override
  String get locationUnavailable =>
      'No hem pogut saber on ets. Torna-ho a provar en un lloc amb més cobertura.';

  @override
  String get locating => 'Buscant la teva ubicació…';

  @override
  String get loadingStations => 'Baixant els preus oficials…';

  @override
  String get errorNetwork =>
      'No hi ha connexió. Comprova la connexió a internet i torna-ho a provar.';

  @override
  String get errorServer =>
      'No s\'han pogut carregar els preus. Torna-ho a provar d\'aquí a una estona.';

  @override
  String noStations(int p1) {
    return 'No hi ha benzineres amb aquest carburant a menys de $p1 km.';
  }

  @override
  String summaryTitle(int p1, int p2) {
    return '$p1 benzineres a menys de $p2 km';
  }

  @override
  String summaryAverage(String p1) {
    return 'Preu mitjà: $p1';
  }

  @override
  String summaryCheapest(String p1, String p2) {
    return 'La més barata: $p1 a $p2';
  }

  @override
  String summarySaving(String p1, int p2) {
    return 'Omplint $p2 L t\'estalvies $p1 respecte a la mitjana';
  }

  @override
  String stationSaving(String p1, int p2) {
    return 'T\'estalvies $p1 en $p2 L';
  }

  @override
  String get unknownBrand => 'Benzinera';

  @override
  String get directions => 'Com arribar-hi';

  @override
  String get offlineData =>
      'Sense connexió: preus desats de l\'última consulta.';

  @override
  String updatedAt(String p1) {
    return 'Preus del $p1';
  }

  @override
  String get dataSource =>
      'Preus oficials amb impostos. Dades: Ministeri per a la Transició Ecològica i el Repte Demogràfic.';

  @override
  String get tankTitle => 'Dipòsit';

  @override
  String tankLiters(int p1) {
    return '$p1 litres';
  }

  @override
  String get tankDetail =>
      'S\'utilitza per calcular quant t\'estalvies en omplir-lo.';

  @override
  String get privacyOptions => 'Opcions de privadesa dels anuncis';

  @override
  String get aboutTitle => 'Quant a';

  @override
  String get aboutText =>
      'Preus de les benzineres d\'Espanya publicats pel Ministeri per a la Transició Ecològica i el Repte Demogràfic, que s\'actualitzen cada 30 minuts. El preu final sempre és el del sortidor.';

  @override
  String get sourceTitle => 'Font de les dades';

  @override
  String get sourceGeoportal => 'Geoportal de Benzineres (Ministeri)';

  @override
  String get sourceService =>
      'Servei oficial de preus de carburants (minetur.gob.es)';

  @override
  String get aboutDisclaimer =>
      'Gasolina Barata és una app independent i no està vinculada al Ministeri ni a cap organisme públic.';

  @override
  String version(String p1) {
    return 'Versió $p1';
  }

  @override
  String get tripTitle => 'Quant em costa el viatge?';

  @override
  String get tripLocked =>
      'Calcula el combustible i el que et costa un viatge si poses benzina a la benzinera més barata.';

  @override
  String get tripDistance => 'Distància del viatge';

  @override
  String tripConsumption(String p1) {
    return 'Amb un consum de $p1 l/100 km (canvia\'l a Configuració)';
  }

  @override
  String tripLiters(String p1) {
    return 'Necessites $p1 litres';
  }

  @override
  String tripCostCheapest(String p1) {
    return 'A la més barata: $p1';
  }

  @override
  String tripCostAverage(String p1) {
    return 'A preu mitjà: $p1';
  }

  @override
  String tripSaving(String p1) {
    return 'T\'estalvies $p1 en el viatge';
  }

  @override
  String get consumptionTitle => 'Consum del cotxe';

  @override
  String consumptionValue(String p1) {
    return '$p1 l/100 km';
  }

  @override
  String get consumptionDetail => 'S\'utilitza a la calculadora de viatges.';

  @override
  String get premiumFeatureTrip => 'Calculadora del cost d\'un viatge';

  @override
  String get premiumSettingsText =>
      'Treu els anuncis i desbloqueja la calculadora de viatges.';

  @override
  String get removeAds => 'Treure els anuncis';

  @override
  String get premiumTitle => 'Premium';

  @override
  String get premiumBack => 'Tornar';

  @override
  String get premiumHeadline => 'Passa\'t a Premium';

  @override
  String get premiumActive => 'Ja ets Premium. Gràcies pel teu suport!';

  @override
  String get premiumBenefitNoAds => 'Sense anuncis';

  @override
  String premiumMonthly(String p1) {
    return '$p1 al mes';
  }

  @override
  String premiumLifetime(String p1) {
    return '$p1, pagament únic per sempre';
  }

  @override
  String get premiumLoading => 'Carregant el preu…';

  @override
  String get premiumStoreUnavailable =>
      'No es pot connectar amb l\'App Store. Torna-ho a provar més tard.';

  @override
  String get premiumRestore => 'Restaura les compres';

  @override
  String get premiumLegal =>
      'La subscripció es renova cada mes i la pots cancel·lar quan vulguis a l\'App Store.';

  @override
  String get lockedWatchAd => 'Mira un anunci i desbloqueja-ho 24 h';

  @override
  String get lockedGoPremium => 'Fes-te Premium';

  @override
  String get rewardedUnavailable =>
      'Ara mateix no hi ha cap anunci disponible. Prova-ho d\'aquí a una estona.';

  @override
  String get privacyPolicy => 'Política de privadesa';

  @override
  String get termsOfUse => 'Termes d\'ús';
}
