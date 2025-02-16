import 'package:flutter/material.dart';
import 'package:bronya/ui/AppDrawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Главная"),
      ),
      drawer: AppDrawer(),
      body: const Center(child: Text("Главный экран")),
    );
  }
}