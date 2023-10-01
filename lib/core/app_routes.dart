import 'package:chat_app/view/screens/auth/login_screen.dart';
import 'package:chat_app/view/screens/auth/register_screen.dart';
import 'package:chat_app/view/screens/home_screen.dart';
import 'package:flutter/material.dart';

import '../view/screens/addNewRoom.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes.login.name: (_) => LoginScreen(),
  AppRoutes.register.name: (_) => RegisterScreen(),
  AppRoutes.home.name: (_) => HomeScreen(),
  AppRoutes.addNewRoom.name: (_) => AddNewRoom(),
};

enum AppRoutes { login, register, home, addNewRoom }
