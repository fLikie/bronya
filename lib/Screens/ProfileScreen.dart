import 'package:bronya/ui/AppDrawer.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Личный кабинет")),
      drawer: AppDrawer(),
      body: const Center(child: Text("Добро пожаловать в профиль!")),
    );
  }
}