import 'package:flutter/material.dart';

abstract class AuthNavigator {
  void showLoading();

  void showMessage(String message);

  void hideLoading();
}

class BaseAuthViewModel extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  AuthNavigator? navigator;
  bool securePassword = true;
  bool obscureText = false;

  String? validatePassword(String value) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  String? validateEmail(String value) {
    final emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if (!emailRegExp.hasMatch(value) || value.trim().isEmpty) {
      return 'Enter a valid email address';
    }
    return null;
  }

  changeSecurePassword() {
    securePassword = !securePassword;
    obscureText = !obscureText;
    notifyListeners();
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
