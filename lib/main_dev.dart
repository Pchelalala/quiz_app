import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'app.dart';
import 'app_config.dart';
import 'localization/translate_preferences.dart';
import 'utils/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  setupLogger();

  final configuredApp = AppConfig(
    appName: 'DEV Flutter Provider Application Starter',
    flavorName: 'dev',
    apiUrl: 'https://run.mocky.io/v3',
    child: Application(),
  );

  final delegate = await LocalizationDelegate.create(
      fallbackLocale: 'en',
      preferences: TranslatePreferences(),
      supportedLocales: [
        'en',
        'uk',
      ]);

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);

  runApp(LocalizedApp(delegate, configuredApp));
}
