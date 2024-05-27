import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";


ThemeData light = ThemeData(
  brightness: Brightness.light,
  colorSchemeSeed: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.grey[100],
  cardColor: Colors.white,
  hintColor: Colors.black,
  dividerColor: Colors.white,
  appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
  //textTheme: const TextTheme(titleMedium: TextStyle(fontSize: 22.0, fontStyle: FontStyle.italic))
);

ThemeData dark = ThemeData(
  brightness: Brightness.dark,
  colorSchemeSeed: Colors.deepOrange,
  scaffoldBackgroundColor: Colors.grey[800],
  cardColor: Colors.grey[700],
  hintColor: Colors.grey[700],
  dividerColor: Colors.white,
  appBarTheme: AppBarTheme(backgroundColor: Colors.grey[700]),
  //textTheme: const TextTheme(titleMedium: TextStyle(fontSize: 22.0, fontStyle: FontStyle.italic))
);

class ThemeNotifier extends ChangeNotifier{

  final String key = "theme";
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late final SharedPreferences prefs;
  late bool _darkTheme;
  late ThemeData _actualThemeData;

  bool get darkTheme => _darkTheme;

  ThemeNotifier() {
    _actualThemeData = light;
    _darkTheme = false;
    _loadFromPrefs();
  }

  getTheme()=>_actualThemeData;

  toogleTheme(){
    _darkTheme = !_darkTheme;
    _darkTheme ? _actualThemeData = dark : _actualThemeData = light;
    _saveToPrefs();

    notifyListeners();
  }

  _loadFromPrefs() async {
    prefs = await _prefs;
    _darkTheme = prefs.getBool(key) ?? false;
    _darkTheme ? _actualThemeData = dark : _actualThemeData = light;
    print("Initial theme is dark: $_darkTheme");
    notifyListeners();
  }

  _saveToPrefs() async {
    await prefs.setBool(key, _darkTheme);
  }
}