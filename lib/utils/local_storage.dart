import 'package:shared_preferences/shared_preferences.dart';

import 'functions.dart';

class SharedPreferencesRepository {
  static SharedPreferences? _prefs;

  static init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static putInteger(String key, int value) {
    if (_prefs != null) _prefs!.setInt(key, value);
  }

  static int getInteger(String key) {
    return _prefs == null ? 0 : _prefs!.getInt(key) ?? 0;
  }

  static putString(String key, String value) {
    iPrint("HEEEEEEERE=====>");
    iPrint(value);
    iPrint(_prefs);
    _prefs?.setString(key, value);
  }

  static String getString(String key) {
    return _prefs?.getString(key) ?? "";
  }

  static removeString(String key, String value) {
    if (_prefs != null) _prefs!.remove(key);
  }

  static putBool(String key, bool value) {
    if (_prefs != null) _prefs!.setBool(key, value);
  }

  static bool getBool(String key) {
    return _prefs == null ? false : _prefs!.getBool(key) ?? false;
  }
}
