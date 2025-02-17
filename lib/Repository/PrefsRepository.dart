

import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepository {

  static const TOKEN = 'TOKEN';

  Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getString(TOKEN) != null || prefs.getString(TOKEN) != "";

    return isLoggedIn;
  }

  void saveLogged(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, token);
  }

  void deleteLogged() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, "");
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(TOKEN) ?? "";
  }
}