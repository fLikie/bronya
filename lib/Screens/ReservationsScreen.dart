import 'package:bronya/ui/AppDrawer.dart';
import 'package:flutter/material.dart';

class ReservationsScreen extends StatelessWidget {
  const ReservationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Бронирования"),
      ),
      drawer: AppDrawer(),
      body: const Center(child: Text("Бронирования")),
    );
  }
}