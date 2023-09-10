import 'package:chat_app/view/screens/auth/login_screen.dart';
import 'package:chat_app/view/screens/auth/register_screen.dart';
import 'package:flutter/material.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.login.name: (_) => LoginScreen(),
  AppRoutes.register.name: (_) => RegisterScreen(),
};

enum AppRoutes { login, register }
