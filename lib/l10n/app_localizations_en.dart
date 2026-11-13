// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LEn extends L {
  LEn([String locale = 'en']) : super(locale);

  @override
  String get settings => 'Settings';

  @override
  String get back => 'Back';

  @override
  String get retry => 'Retry';

  @override
  String get fuelGasolina95 => 'Petrol 95';

  @override
  String get fuelGasolina98 => 'Petrol 98';

  @override
  String get fuelDiesel => 'Diesel';

  @override
  String get fuelDieselPremium => 'Premium diesel';

  @override
  String get fuelGlp => 'LPG';

  @override
  String radiusKm(int p1) {
    return '$p1 km';
  }

  @override
  String get sortPrice => 'Price';

  @override
  String get sortDistance => 'Distance';

  @override
  String get locationPermission =>
      'We need your location to find the cheapest petrol stations near you. It is only used on your phone and never sent anywhere.';

  @override
  String get allowLocation => 'Allow location';

  @override
  String get locationDisabled => 'Location is turned off on your phone.';

  @override
  String get openSettings => 'Turn on location';

  @override
  String get locationUnavailable =>
      'We could not find where you are. Try again somewhere with better signal.';

  @override
  String get locating => 'Finding your location…';

  @override
  String get loadingStations => 'Downloading official prices…';

  @override
  String get errorNetwork =>
      'No connection. Check your internet and try again.';

  @override
  String get errorServer => 'Prices could not be loaded. Try again later.';

  @override
  String noStations(int p1) {
    return 'No stations with this fuel within $p1 km.';
  }

  @override
  String summaryTitle(int p1, int p2) {
    return '$p1 stations within $p2 km';
  }

  @override
  String summaryAverage(String p1) {
    return 'Average price: $p1';
  }

  @override
  String summaryCheapest(String p1, String p2) {
    return 'Cheapest: $p1, $p2 away';
  }

  @override
  String summarySaving(String p1, int p2) {
    return 'Filling $p2 L saves you $p1 vs. the average';
  }

  @override
  String stationSaving(String p1, int p2) {
    return 'You save $p1 on $p2 L';
  }

  @override
  String get unknownBrand => 'Petrol station';

  @override
  String get directions => 'Directions';

  @override
  String get offlineData => 'Offline: prices saved from the last check.';

  @override
  String updatedAt(String p1) {
    return 'Prices from $p1';
  }

  @override
  String get dataSource =>
      'Official prices including taxes. Data: Spanish Ministry for the Ecological Transition.';

  @override
  String get tankTitle => 'Tank';

  @override
  String tankLiters(int p1) {
    return '$p1 litres';
  }

  @override
  String get tankDetail =>
      'Used to work out how much you save when filling up.';

  @override
  String get privacyOptions => 'Ad privacy options';

  @override
  String get aboutTitle => 'About';

  @override
  String get aboutText =>
      'Prices of Spanish petrol stations published by the Ministry for the Ecological Transition, updated every 30 minutes. The pump price always prevails.';

  @override
  String get sourceTitle => 'Data source';

  @override
  String get sourceGeoportal => 'Petrol Station Geoportal (Spanish Ministry)';

  @override
  String get sourceService => 'Official fuel price service (minetur.gob.es)';

  @override
  String get aboutDisclaimer =>
      'Gasolina Barata is an independent app and is not affiliated with the Ministry or any government body.';

  @override
  String version(String p1) {
    return 'Version $p1';
  }

  @override
  String get tripTitle => 'How much will the trip cost?';

  @override
  String get tripLocked =>
      'Work out the fuel and the cost of a trip filling up at the cheapest station.';

  @override
  String get tripDistance => 'Trip distance';

  @override
  String tripConsumption(String p1) {
    return 'With a consumption of $p1 l/100 km (change it in Settings)';
  }

  @override
  String tripLiters(String p1) {
    return 'You need $p1 litres';
  }

  @override
  String tripCostCheapest(String p1) {
    return 'At the cheapest: $p1';
  }

  @override
  String tripCostAverage(String p1) {
    return 'At the average price: $p1';
  }

  @override
  String tripSaving(String p1) {
    return 'You save $p1 on the trip';
  }

  @override
  String get consumptionTitle => 'Car consumption';

  @override
  String consumptionValue(String p1) {
    return '$p1 l/100 km';
  }

  @override
  String get consumptionDetail => 'Used in the trip calculator.';

  @override
  String get premiumFeatureTrip => 'Trip cost calculator';

  @override
  String get premiumSettingsText =>
      'Remove the ads and unlock the trip calculator.';

  @override
  String get removeAds => 'Remove ads';

  @override
  String get premiumTitle => 'Premium';

  @override
  String get premiumBack => 'Back';

  @override
  String get premiumHeadline => 'Go Premium';

  @override
  String get premiumActive => 'You are Premium. Thanks for your support!';

  @override
  String get premiumBenefitNoAds => 'No ads';

  @override
  String premiumMonthly(String p1) {
    return '$p1 per month';
  }

  @override
  String premiumLifetime(String p1) {
    return '$p1, one-off payment forever';
  }

  @override
  String get premiumLoading => 'Loading price…';

  @override
  String get premiumStoreUnavailable =>
      'Cannot connect to the App Store. Try again later.';

  @override
  String get premiumRestore => 'Restore purchases';

  @override
  String get premiumLegal =>
      'The subscription renews every month and you can cancel it at any time in the App Store.';

  @override
  String get lockedWatchAd => 'Watch an ad to unlock for 24 h';

  @override
  String get lockedGoPremium => 'Go Premium';

  @override
  String get rewardedUnavailable =>
      'No ad is available right now. Try again in a while.';

  @override
  String get privacyPolicy => 'Privacy policy';

  @override
  String get termsOfUse => 'Terms of use';
}
