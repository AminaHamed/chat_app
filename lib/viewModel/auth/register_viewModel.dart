import 'package:chat_app/DB/dataBase.dart';
import 'package:chat_app/model/myUser.dart';
import 'package:chat_app/model/sharedData.dart';
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
      var data = await MyDataBase.insertUser(MyUser(
          id: user.user?.uid ?? "",
          userName: userNameController.text,
          email: emailController.text,
          password: passwordController.text));

      passwordController.clear();
      userNameController.clear();
      emailController.clear();
      confirmPasswordController.clear();
      navigator?.hideLoading();

      if (data != null) {
        SharedData.userData = data;
        navigator?.goToHome();
      } else {
        navigator?.showMessage("can't insert user");
      }
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
