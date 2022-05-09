import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/view_models/home_vm.dart';
import 'package:quiz_app/view_models/theme_vm.dart';
import 'app_config.dart';
import 'services/api_service.dart';

class Application extends StatefulWidget {
  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    final localizationDelegate = LocalizedApp.of(context).delegate;
    final appConfig = AppConfig.of(context)!;
    final _apiService = ApiService(appConfig.apiUrl);

    return LocalizationProvider(
      state: LocalizationProvider.of(context).state,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeViewModel()),
          ChangeNotifierProvider(
              create: (context) => HomeViewModel(_apiService)),
          Provider(create: (context) => _apiService),
        ],
        child: Consumer<ThemeViewModel>(builder: (context, themeViewModel, _) {
          return MaterialApp(
            title: 'Flutter Provider Starter',
            theme: themeViewModel.getThemeData,
            initialRoute: splashScreenRoute,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              localizationDelegate
            ],
            supportedLocales: localizationDelegate.supportedLocales,
            locale: localizationDelegate.currentLocale,
            routes: applicationRoutes,
          );
        }),
      ),
    );
  }
}
