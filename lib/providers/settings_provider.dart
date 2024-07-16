import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  //SettingsProvider => data holder
  ThemeMode currentTheme = ThemeMode.light;

  //String currentLang = 'ar';

  String currentLang = 'en';

  void changeAppLocal(String newLang) async {
    if (newLang == currentLang) return;
    currentLang = newLang;

    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save an String value to 'action' key.
    await prefs.setString("language", currentLang);
    notifyListeners();
  }

  void updateAppTheme(ThemeMode newTheme) async {
    if (newTheme == currentTheme) return;
    currentTheme = newTheme;

    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save an double value to 'decimal' key.
    await prefs.setBool(
        "isDark", currentTheme == ThemeMode.light ? false : true);

    notifyListeners();
  }

  Future<void> initSharedPreference() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    var language = prefs.getString("language");
    if (language != null) {
      changeAppLocal(language);
    }
    var isDark = prefs.getBool("isDark");
    if (isDark == true) {
      updateAppTheme(ThemeMode.dark);
    } else if (isDark == false) {
      updateAppTheme(ThemeMode.light);
    }
  }

  // void updateAppLocal(String newLang) {
  //   if (newLang == currentLang) return;
  //   currentLang == newLang;
  //
  //   notifyListeners();
  // }
}
