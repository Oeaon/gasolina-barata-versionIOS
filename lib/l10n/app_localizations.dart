import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ca.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_gl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of L
/// returned by `L.of(context)`.
///
/// Applications need to include `L.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: L.localizationsDelegates,
///   supportedLocales: L.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the L.supportedLocales
/// property.
abstract class L {
  L(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static L of(BuildContext context) {
    return Localizations.of<L>(context, L)!;
  }

  static const LocalizationsDelegate<L> delegate = _LDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('en'),
    Locale('es'),
    Locale('gl'),
  ];

  /// No description provided for @settings.
  ///
  /// In es, this message translates to:
  /// **'Ajustes'**
  String get settings;

  /// No description provided for @back.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get back;

  /// No description provided for @retry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get retry;

  /// No description provided for @fuelGasolina95.
  ///
  /// In es, this message translates to:
  /// **'Gasolina 95'**
  String get fuelGasolina95;

  /// No description provided for @fuelGasolina98.
  ///
  /// In es, this message translates to:
  /// **'Gasolina 98'**
  String get fuelGasolina98;

  /// No description provided for @fuelDiesel.
  ///
  /// In es, this message translates to:
  /// **'Diésel'**
  String get fuelDiesel;

  /// No description provided for @fuelDieselPremium.
  ///
  /// In es, this message translates to:
  /// **'Diésel Premium'**
  String get fuelDieselPremium;

  /// No description provided for @fuelGlp.
  ///
  /// In es, this message translates to:
  /// **'GLP'**
  String get fuelGlp;

  /// No description provided for @radiusKm.
  ///
  /// In es, this message translates to:
  /// **'{p1} km'**
  String radiusKm(int p1);

  /// No description provided for @sortPrice.
  ///
  /// In es, this message translates to:
  /// **'Precio'**
  String get sortPrice;

  /// No description provided for @sortDistance.
  ///
  /// In es, this message translates to:
  /// **'Distancia'**
  String get sortDistance;

  /// No description provided for @locationPermission.
  ///
  /// In es, this message translates to:
  /// **'Para buscar las gasolineras más baratas cerca de ti necesitamos tu ubicación. Solo se usa en el móvil y no se envía a ningún sitio.'**
  String get locationPermission;

  /// No description provided for @allowLocation.
  ///
  /// In es, this message translates to:
  /// **'Permitir ubicación'**
  String get allowLocation;

  /// No description provided for @locationDisabled.
  ///
  /// In es, this message translates to:
  /// **'La ubicación del móvil está desactivada.'**
  String get locationDisabled;

  /// No description provided for @openSettings.
  ///
  /// In es, this message translates to:
  /// **'Activar ubicación'**
  String get openSettings;

  /// No description provided for @locationUnavailable.
  ///
  /// In es, this message translates to:
  /// **'No hemos podido saber dónde estás. Prueba otra vez en un sitio con mejor señal.'**
  String get locationUnavailable;

  /// No description provided for @locating.
  ///
  /// In es, this message translates to:
  /// **'Buscando tu ubicación…'**
  String get locating;

  /// No description provided for @loadingStations.
  ///
  /// In es, this message translates to:
  /// **'Descargando precios oficiales…'**
  String get loadingStations;

  /// No description provided for @errorNetwork.
  ///
  /// In es, this message translates to:
  /// **'No hay conexión. Comprueba tu internet e inténtalo de nuevo.'**
  String get errorNetwork;

  /// No description provided for @errorServer.
  ///
  /// In es, this message translates to:
  /// **'No se han podido cargar los precios. Inténtalo dentro de un rato.'**
  String get errorServer;

  /// No description provided for @noStations.
  ///
  /// In es, this message translates to:
  /// **'No hay gasolineras con este carburante a menos de {p1} km.'**
  String noStations(int p1);

  /// No description provided for @summaryTitle.
  ///
  /// In es, this message translates to:
  /// **'{p1} gasolineras a menos de {p2} km'**
  String summaryTitle(int p1, int p2);

  /// No description provided for @summaryAverage.
  ///
  /// In es, this message translates to:
  /// **'Precio medio: {p1}'**
  String summaryAverage(String p1);

  /// No description provided for @summaryCheapest.
  ///
  /// In es, this message translates to:
  /// **'La más barata: {p1} a {p2}'**
  String summaryCheapest(String p1, String p2);

  /// No description provided for @summarySaving.
  ///
  /// In es, this message translates to:
  /// **'Llenando {p2} L ahorras {p1} frente a la media'**
  String summarySaving(String p1, int p2);

  /// No description provided for @stationSaving.
  ///
  /// In es, this message translates to:
  /// **'Ahorras {p1} en {p2} L'**
  String stationSaving(String p1, int p2);

  /// No description provided for @unknownBrand.
  ///
  /// In es, this message translates to:
  /// **'Gasolinera'**
  String get unknownBrand;

  /// No description provided for @directions.
  ///
  /// In es, this message translates to:
  /// **'Cómo llegar'**
  String get directions;

  /// No description provided for @offlineData.
  ///
  /// In es, this message translates to:
  /// **'Sin conexión: precios guardados de la última consulta.'**
  String get offlineData;

  /// No description provided for @updatedAt.
  ///
  /// In es, this message translates to:
  /// **'Precios del {p1}'**
  String updatedAt(String p1);

  /// No description provided for @dataSource.
  ///
  /// In es, this message translates to:
  /// **'Precios oficiales con impuestos. Datos: Ministerio para la Transición Ecológica y el Reto Demográfico.'**
  String get dataSource;

  /// No description provided for @tankTitle.
  ///
  /// In es, this message translates to:
  /// **'Depósito'**
  String get tankTitle;

  /// No description provided for @tankLiters.
  ///
  /// In es, this message translates to:
  /// **'{p1} litros'**
  String tankLiters(int p1);

  /// No description provided for @tankDetail.
  ///
  /// In es, this message translates to:
  /// **'Se usa para calcular cuánto ahorras al llenar.'**
  String get tankDetail;

  /// No description provided for @privacyOptions.
  ///
  /// In es, this message translates to:
  /// **'Opciones de privacidad de anuncios'**
  String get privacyOptions;

  /// No description provided for @aboutTitle.
  ///
  /// In es, this message translates to:
  /// **'Acerca de'**
  String get aboutTitle;

  /// No description provided for @aboutText.
  ///
  /// In es, this message translates to:
  /// **'Precios de las gasolineras de España publicados por el Ministerio para la Transición Ecológica y el Reto Demográfico, que se actualizan cada 30 minutos. El precio final lo marca siempre el surtidor.'**
  String get aboutText;

  /// No description provided for @sourceTitle.
  ///
  /// In es, this message translates to:
  /// **'Fuente de los datos'**
  String get sourceTitle;

  /// No description provided for @sourceGeoportal.
  ///
  /// In es, this message translates to:
  /// **'Geoportal de Gasolineras (Ministerio)'**
  String get sourceGeoportal;

  /// No description provided for @sourceService.
  ///
  /// In es, this message translates to:
  /// **'Servicio oficial de precios de carburantes (minetur.gob.es)'**
  String get sourceService;

  /// No description provided for @aboutDisclaimer.
  ///
  /// In es, this message translates to:
  /// **'Gasolina Barata es una app independiente y no está vinculada al Ministerio ni a ningún organismo público.'**
  String get aboutDisclaimer;

  /// No description provided for @version.
  ///
  /// In es, this message translates to:
  /// **'Versión {p1}'**
  String version(String p1);

  /// No description provided for @tripTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Cuánto me cuesta el viaje?'**
  String get tripTitle;

  /// No description provided for @tripLocked.
  ///
  /// In es, this message translates to:
  /// **'Calcula el combustible y lo que te cuesta un viaje repostando en la gasolinera más barata.'**
  String get tripLocked;

  /// No description provided for @tripDistance.
  ///
  /// In es, this message translates to:
  /// **'Distancia del viaje'**
  String get tripDistance;

  /// No description provided for @tripConsumption.
  ///
  /// In es, this message translates to:
  /// **'Con un consumo de {p1} l/100 km (cámbialo en Ajustes)'**
  String tripConsumption(String p1);

  /// No description provided for @tripLiters.
  ///
  /// In es, this message translates to:
  /// **'Necesitas {p1} litros'**
  String tripLiters(String p1);

  /// No description provided for @tripCostCheapest.
  ///
  /// In es, this message translates to:
  /// **'En la más barata: {p1}'**
  String tripCostCheapest(String p1);

  /// No description provided for @tripCostAverage.
  ///
  /// In es, this message translates to:
  /// **'A precio medio: {p1}'**
  String tripCostAverage(String p1);

  /// No description provided for @tripSaving.
  ///
  /// In es, this message translates to:
  /// **'Te ahorras {p1} en el viaje'**
  String tripSaving(String p1);

  /// No description provided for @consumptionTitle.
  ///
  /// In es, this message translates to:
  /// **'Consumo del coche'**
  String get consumptionTitle;

  /// No description provided for @consumptionValue.
  ///
  /// In es, this message translates to:
  /// **'{p1} l/100 km'**
  String consumptionValue(String p1);

  /// No description provided for @consumptionDetail.
  ///
  /// In es, this message translates to:
  /// **'Se usa en la calculadora de viajes.'**
  String get consumptionDetail;

  /// No description provided for @premiumFeatureTrip.
  ///
  /// In es, this message translates to:
  /// **'Calculadora del coste de un viaje'**
  String get premiumFeatureTrip;

  /// No description provided for @premiumSettingsText.
  ///
  /// In es, this message translates to:
  /// **'Quita los anuncios y desbloquea la calculadora de viajes.'**
  String get premiumSettingsText;

  /// No description provided for @removeAds.
  ///
  /// In es, this message translates to:
  /// **'Quitar anuncios'**
  String get removeAds;

  /// No description provided for @premiumTitle.
  ///
  /// In es, this message translates to:
  /// **'Premium'**
  String get premiumTitle;

  /// No description provided for @premiumBack.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get premiumBack;

  /// No description provided for @premiumHeadline.
  ///
  /// In es, this message translates to:
  /// **'Pásate a Premium'**
  String get premiumHeadline;

  /// No description provided for @premiumActive.
  ///
  /// In es, this message translates to:
  /// **'Ya eres Premium. ¡Gracias por tu apoyo!'**
  String get premiumActive;

  /// No description provided for @premiumBenefitNoAds.
  ///
  /// In es, this message translates to:
  /// **'Sin anuncios'**
  String get premiumBenefitNoAds;

  /// No description provided for @premiumMonthly.
  ///
  /// In es, this message translates to:
  /// **'{p1} al mes'**
  String premiumMonthly(String p1);

  /// No description provided for @premiumLifetime.
  ///
  /// In es, this message translates to:
  /// **'{p1}, pago único para siempre'**
  String premiumLifetime(String p1);

  /// No description provided for @premiumLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando precio…'**
  String get premiumLoading;

  /// No description provided for @premiumStoreUnavailable.
  ///
  /// In es, this message translates to:
  /// **'No se puede conectar con el App Store. Inténtalo más tarde.'**
  String get premiumStoreUnavailable;

  /// No description provided for @premiumRestore.
  ///
  /// In es, this message translates to:
  /// **'Restaurar compras'**
  String get premiumRestore;

  /// No description provided for @premiumLegal.
  ///
  /// In es, this message translates to:
  /// **'La suscripción se renueva cada mes y puedes cancelarla cuando quieras en el App Store.'**
  String get premiumLegal;

  /// No description provided for @lockedWatchAd.
  ///
  /// In es, this message translates to:
  /// **'Ver un anuncio y desbloquear 24 h'**
  String get lockedWatchAd;

  /// No description provided for @lockedGoPremium.
  ///
  /// In es, this message translates to:
  /// **'Hazte Premium'**
  String get lockedGoPremium;

  /// No description provided for @rewardedUnavailable.
  ///
  /// In es, this message translates to:
  /// **'No hay ningún anuncio disponible ahora mismo. Prueba dentro de un rato.'**
  String get rewardedUnavailable;

  /// No description provided for @privacyPolicy.
  ///
  /// In es, this message translates to:
  /// **'Política de privacidad'**
  String get privacyPolicy;

  /// No description provided for @termsOfUse.
  ///
  /// In es, this message translates to:
  /// **'Términos de uso'**
  String get termsOfUse;
}

class _LDelegate extends LocalizationsDelegate<L> {
  const _LDelegate();

  @override
  Future<L> load(Locale locale) {
    return SynchronousFuture<L>(lookupL(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ca', 'en', 'es', 'gl'].contains(locale.languageCode);

  @override
  bool shouldReload(_LDelegate old) => false;
}

L lookupL(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return LCa();
    case 'en':
      return LEn();
    case 'es':
      return LEs();
    case 'gl':
      return LGl();
  }

  throw FlutterError(
    'L.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
