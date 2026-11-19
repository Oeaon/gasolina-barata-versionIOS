import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'app_info.dart';
import 'data/location.dart';
import 'data/settings_store.dart';
import 'data/stations_repository.dart';
import 'l10n/app_localizations.dart';
import 'monetization/monetization.dart';
import 'monetization/monetization_ui.dart';
import 'ui/main_controller.dart';
import 'ui/settings_screen.dart';
import 'ui/stations_screen.dart';
import 'ui/vehicle_settings.dart';

const _seed = Color(0xFF0B57D0);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final monetization = await Monetization.create();
  final settings = await SettingsStore.open();
  final controller = MainController(settings, StationsRepository(), LocationProvider());
  runApp(App(monetization: monetization, controller: controller));
}

class App extends StatelessWidget {
  const App({super.key, required this.monetization, required this.controller});

  final Monetization monetization;
  final MainController controller;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppInfo.name,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: _seed)),
      darkTheme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: _seed, brightness: Brightness.dark)),
      localizationsDelegates: const [
        L.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: L.supportedLocales,
      home: Root(monetization: monetization, controller: controller),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key, required this.monetization, required this.controller});

  final Monetization monetization;
  final MainController controller;

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
    // El consentimiento se pide con la primera pantalla ya dibujada.
    WidgetsBinding.instance.addPostFrameCallback((_) => widget.monetization.gatherConsent());
  }

  void _openPremium() {
    final l = L.of(context);
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => PremiumScreen(
        monetization: widget.monetization,
        features: [l.premiumFeatureTrip],
        privacyUrl: AppInfo.privacyUrl,
        termsUrl: AppInfo.termsUrl,
      ),
    ));
  }

  Future<void> _openSettings() async {
    await Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) {
      final l = L.of(context);
      return SettingsScreen(
        monetization: widget.monetization,
        onOpenPremium: _openPremium,
        sourceLabels: [l.sourceGeoportal, l.sourceService],
        appSection: [VehicleSettings(settings: widget.controller.settings)],
      );
    }));
    // Volver a la lista es una pausa natural para un intersticial.
    widget.monetization.maybeShowInterstitial();
  }

  @override
  Widget build(BuildContext context) {
    return StationsScreen(
      controller: widget.controller,
      monetization: widget.monetization,
      onOpenSettings: _openSettings,
      onOpenPremium: _openPremium,
    );
  }
}
