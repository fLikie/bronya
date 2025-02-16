

import 'package:shared_preferences/shared_preferences.dart';

class PrefsRepository {

  static const isUserLogged = 'isLoggedIn';

  Future<bool> isLogged() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(isUserLogged) ?? false;

    return isLoggedIn;
  }

  void saveLogged() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(isUserLogged, true);
  }

  void deleteLogged() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(isUserLogged, false);
  }
}