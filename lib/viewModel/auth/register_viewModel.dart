import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

abstract class RegisterNavigator {
  void showLoading();

  void showMessage(String message);

  void hideLoading();
}

class RegisterViewModel extends ChangeNotifier {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RegisterNavigator? navigator;
  bool securePassword = true;
  bool obscureText = false;

  String? validateUserName(String value) {
    if (value.trim().isEmpty) {
      return 'Enter Your name';
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

  String? validatePassword(String value) {
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }

    return null;
  }

  String? validateConfirmPassword(String value) {
    if (value.trim().isEmpty) {
      return "confirm password is required";
    }
    if (value != passwordController.text) {
      return "password doesn't match!";
    }
    return null;
  }

  changeSecurePassword() {
    securePassword = !securePassword;
    obscureText = !obscureText;
    notifyListeners();
  }

  Future<void> registerWithEmailAndPassword() async {
    try {
      navigator?.showLoading();
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      navigator?.hideLoading();
      //TODO handel successful register
      navigator?.showMessage(user.user?.uid ?? '');
    } catch (e) {
      navigator?.hideLoading();
      navigator?.showMessage(e.toString());
    }
  }
}
