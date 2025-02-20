import 'package:bronya/Repository/AuthRepository.dart';
import 'package:bronya/Repository/PrefsRepository.dart';
import 'package:bronya/Screens/HomeScreen.dart';
import 'package:bronya/Screens/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {

  final _phoneController  = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _prefsRepository = PrefsRepository();
  final _authRepository = AuthRepository();
  final maskFormatter = MaskTextInputFormatter(
    mask: '+7 (###) ###-##-##',
    filter: { "#": RegExp(r'[0-9]') },
    type: MaskAutoCompletionType.lazy,
  );

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      var phone = '7${maskFormatter.getUnmaskedText()}';
      var token = await _authRepository.login(phone, _passwordController.text);
      if (token != null) {
        _showSnackBar("Вход успешен");
        _saveLogged(token);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => HomeScreen())
        );
      } else {
        _showSnackBar("Вход не прошел");
      }
    }
  }

  void _showSnackBar(String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(text)),
    );
  }

  void _saveLogged(String token) {
    _prefsRepository.saveLogged(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Вход',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [maskFormatter],
                  decoration: const InputDecoration(
                    labelText: 'Номер телефона',
                    hintText: '+7 999 123-45-67',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Введите корректный номер телефона';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Пароль',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.length < 6) {
                      return 'Пароль должен быть минимум 6 символов';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('Войти'),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: const Text('Нет аккаунта? Зарегистрироваться'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}