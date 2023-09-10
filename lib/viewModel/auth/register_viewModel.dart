import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterViewModel extends ChangeNotifier {
  bool securePassword = true;
  bool obscureText = false;
  String email = 'test@gmail.com';
  String password = '123456';

  changeSecurePassword() {
    securePassword = !securePassword;
    obscureText = !obscureText;
    notifyListeners();
  }

  Future<void> registerWithEmailAndPassword() async {
    try {
      // Add Firebase registration logic here
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('okkkkkkk');

      // Notify listeners if needed
      // notifyListeners();
    } catch (e) {
      print('Error during registration: $e');
      // Handle registration errors
    }
  }
}
