import 'dart:convert';

import 'package:bronya/Repository/PrefsRepository.dart';
import 'package:http/http.dart' as http;

class AuthRepository {

  final host = "http://zabron.space/api";
  final RESPONSE_OK = 200;
  final RESPONSE_CREATED = 201;
  final _prefsRepository = PrefsRepository();

  Future<String?> login(String email, String password) async {
    final url = Uri.parse("$host/login");
    final response = await http.post(
      url,
      headers: { "Content-Type": "application/json" },
      body: jsonEncode({ "email": email, "password": password }),
    );

    if (response.statusCode == RESPONSE_OK) {
      final data = jsonDecode(response.body);
      return data["token"];
    } else {
      return null;
    }
  }

  Future<String?> register(String email, String password) async {
    final url = Uri.parse("$host/register");
    final response = await http.post(
      url,
      headers: { "Content-Type": "application/json" },
      body: jsonEncode({ "email": email, "password": password}),
    );

    if (response.statusCode == RESPONSE_CREATED) {
      final data = jsonDecode(response.body);
      return data["token"];
    } else {
      return null;
    }
  }

  void logout() {
    _prefsRepository.deleteLogged();
  }
}