

import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefManager {

  static final SharedPrefManager instance = SharedPrefManager._init();
  SharedPrefManager._init();

  Future<void> savePref(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<String> getPref(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getString(key)!;
  }
  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
     await prefs.clear();
  }

}