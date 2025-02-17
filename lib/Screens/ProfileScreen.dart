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
      appBar: AppBar(
        title: const Text("Личный кабинет"),
        backgroundColor: Colors.teal, // Можно сменить на любой цвет
      ),
      drawer: AppDrawer(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent], // Градиент фона
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0), // Отступы вокруг содержимого
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        "Добро пожаловать в профиль!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _logout(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal, // Цвет кнопки
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Размер кнопки
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Закругление углов
                          ),
                        ),
                        child: const Text(
                          "Выйти из профиля",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    _authRepository.logout();
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => AuthScreen()));
  }
}