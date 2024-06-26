import 'package:chat_app/core/base/base.dart';
import 'package:flutter/material.dart';

abstract class AuthNavigator extends BaseNavigator {
  void goToHome();
}

class BaseAuthViewModel extends BaseViewModel<AuthNavigator> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
