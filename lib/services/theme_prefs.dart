import 'package:shared_preferences/shared_preferences.dart';

class ThemeSettings {
  static SharedPreferences? _sharedPrefs;
  static const themeStatus = "ThemeStatus";

  init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
  }

  static setTheme(bool value) async {
    return await _sharedPrefs!.setBool(themeStatus, value);
  }

  static getTheme() {
    return _sharedPrefs!.getBool(themeStatus) ?? false;
  }
}
