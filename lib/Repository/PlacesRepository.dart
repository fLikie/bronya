import 'dart:convert';

import 'package:bronya/Repository/PrefsRepository.dart';
import 'package:bronya/model/Place.dart';
import 'package:http/http.dart' as http;

class PlacesRepository {

  final _prefsRepository = PrefsRepository();
  final host = "http://zabron.space/api";

  Future<List<Place>> fetchPlaces() async {
    final token = await _prefsRepository.getToken();

    if (token == null) {
      throw Exception('JWT токен не найден. Пользователь не авторизован.');
    }


    final url = Uri.parse('$host/places'); // Замените на URL вашего бэкенда
    final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      return jsonData.map((item) => Place.fromJson(item)).toList();
    } else {
      throw Exception('Ошибка загрузки заведений: ${response.statusCode}');
    }
  }
}