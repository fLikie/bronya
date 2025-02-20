import 'dart:convert';

import 'package:bronya/Repository/PrefsRepository.dart';
import 'package:bronya/model/Place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PlaceDetailScreen extends StatefulWidget {
  final Place place;

  const PlaceDetailScreen({Key? key, required this.place}) : super(key: key);

  @override
  _PlaceDetailScreenState createState() => _PlaceDetailScreenState();
}

class _PlaceDetailScreenState extends State<PlaceDetailScreen> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  final _prefsRepository = PrefsRepository();

  @override
  void initState() {
    super.initState();
    // Инициализируем текущими датой и временем
    selectedDate = DateTime.now();
    selectedTime = TimeOfDay.now();
  }

  // Функция выбора даты
  Future<void> _pickDate() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  // Функция выбора времени
  Future<void> _pickTime() async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (time != null) {
      setState(() {
        selectedTime = time;
      });
    }
  }

  // Функция бронирования заведения
  Future<void> _bookPlace() async {
    if (selectedDate == null || selectedTime == null) return;

    final bookingDate = "${selectedDate!.year.toString().padLeft(4, '0')}-"
        "${selectedDate!.month.toString().padLeft(2, '0')}-"
        "${selectedDate!.day.toString().padLeft(2, '0')}";

    // Форматируем время в виде "HH:MM:SS" (секунды можно задать как "00")
    final bookingTime = "${selectedTime!.hour.toString().padLeft(2, '0')}:"
        "${selectedTime!.minute.toString().padLeft(2, '0')}:00";

    final token = await _prefsRepository.getToken();
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Необходимо авторизоваться")),
      );
      return;
    }

    final url = Uri.parse('http://zabron.space/api/bookings');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'place_id': widget.place.id,
        'date': bookingDate,
        'time_slot': bookingTime,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Бронирование успешно!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ошибка бронирования: ${response.statusCode}")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.place.name),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Изображение заведения
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Image.network(
                widget.place.imageUrl ?? "",
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    color: Colors.grey.shade300,
                    child: const Center(
                      child: Icon(Icons.error, size: 50, color: Colors.red),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                widget.place.description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
            // Выбор даты бронирования
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Дата бронирования",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedDate != null
                            ? "${selectedDate!.toLocal()}".split(' ')[0]
                            : "Выберите дату",
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _pickDate,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    child: const Text("Выбрать дату"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Выбор времени бронирования
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Время бронирования",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        selectedTime != null
                            ? selectedTime!.format(context)
                            : "Выберите время",
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _pickTime,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                    child: const Text("Выбрать время"),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Кнопка бронирования
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: _bookPlace,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: const Text(
                  "Забронировать",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}