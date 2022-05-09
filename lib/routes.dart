import 'package:flutter/material.dart';

import 'flavor_banner.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

const String homeScreenRoute = '/home_screen';
const String splashScreenRoute = '/splash_screen';
const String resultsScreenRoute = '/results_screen';

Map<String, WidgetBuilder> applicationRoutes = <String, WidgetBuilder>{
  splashScreenRoute: (context) => SplashScreen(),
  homeScreenRoute: (context) => const FlavorBanner(child: HomeScreen()),
  //resultsScreenRoute: (context) => const ResultsScreen(),
};
