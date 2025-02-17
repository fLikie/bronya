import 'package:bronya/Repository/AuthRepository.dart';
import 'package:bronya/Screens/AuthScreen.dart';
import 'package:bronya/ui/AppDrawer.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final _authRepository = AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Личный кабинет")),
      drawer: AppDrawer(),
      body: Column(
          children: [
            Text("Добро пожаловать в профиль!"),
            ElevatedButton(
                onPressed: () {
                  _logout(context);
                },
                child: const Text("Выйти из профиля")
            )
          ]
      ),
    );
  }

  void _logout(BuildContext context) {
    _authRepository.logout();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => AuthScreen()));
  }
}