

import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepository {

  static const TOKEN = 'TOKEN';

  Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    var token = prefs.getString(TOKEN);
    bool isLoggedIn = token != null;

    return isLoggedIn;
  }

  void saveLogged(String token) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, token);
  }

  void deleteLogged() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    String token = prefs.getString(TOKEN) ?? "";
    return token;
  }
}