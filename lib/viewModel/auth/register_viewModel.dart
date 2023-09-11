import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'baseAuthViewModel.dart';

class RegisterViewModel extends BaseAuthViewModel {
  TextEditingController userNameController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  String? validateUserName(String value) {
    if (value.trim().isEmpty) {
      return 'Enter Your name';
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

  Future<void> registerWithEmailAndPassword() async {
    try {
      navigator?.showLoading();
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      navigator?.hideLoading();
      passwordController.text = '';
      userNameController.text = '';
      emailController.text = '';
      confirmPasswordController.text = '';
      //TODO handel successful register
      navigator?.showMessage(user.user?.uid ?? '');
    } catch (e) {
      navigator?.hideLoading();
      navigator?.showMessage(e.toString());
    }
  }

  @override
  void dispose() {
    userNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}
