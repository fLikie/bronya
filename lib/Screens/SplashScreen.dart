import 'package:bronya/Repository/PrefsRepository.dart';
import 'package:bronya/Screens/AuthScreen.dart';
import 'package:bronya/Screens/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  var prefsRepository = PrefsRepository();

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 2)); // Имитируем загрузку

    bool isLoggedIn = await prefsRepository.isLogged();

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const FlutterLogo(size: 100),
            const SizedBox(height: 20),
            const Text(
              'Загрузка...',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}