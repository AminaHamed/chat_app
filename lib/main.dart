import 'package:chat_app/DB/dataBase.dart';
import 'package:chat_app/core/app_routes.dart';
import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/model/myUser.dart';
import 'package:chat_app/model/sharedData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    MyUser? myUser = await MyDataBase.getUserById(user.uid ?? '');
    SharedData.userData = myUser;
  }
  runApp(MyApp(user));
}

class MyApp extends StatelessWidget {
  final User? user;

  const MyApp(this.user, {super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.myTheme,
      title: 'Chat App',
      routes: routes,
      initialRoute: user != null ? AppRoutes.home.name : AppRoutes.login.name,
    );
  }
}
