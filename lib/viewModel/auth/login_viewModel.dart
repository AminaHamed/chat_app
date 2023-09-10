import 'package:flutter/foundation.dart';

class LoginViewModel extends ChangeNotifier {
  bool securePassword = true;
  bool obscureText = false;

  changeSecurePassword() {
    securePassword = !securePassword;
    obscureText = !obscureText;
    notifyListeners();
  }
}
