//import 'dart:js';

import 'package:daily_missions_app/providers/authentication_provider.dart';
import 'package:daily_missions_app/providers/settings_provider.dart';
import 'package:daily_missions_app/styles/mytheme.dart';
import 'package:daily_missions_app/ui/auth/login/login_screen.dart';
import 'package:daily_missions_app/ui/auth/register/register_screen.dart';
import 'package:daily_missions_app/ui/home/home_screen.dart';
import 'package:daily_missions_app/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // to initialize firebase before runApp
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => SettingsProvider()
        ..initSharedPreference(), //one obj shared on whole application, that called => (single instance)
    ),
    ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  late SettingsProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<SettingsProvider>(context);
    //initSharedPreference();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: [
        Locale('en'), // English
        Locale('ar'), // arabic
      ],
      locale: Locale(provider.currentLang),
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.currentTheme,
      routes: {
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
