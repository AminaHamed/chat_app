import 'package:chat_app/DB/dataBase.dart';
import 'package:chat_app/model/myUser.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/sharedData.dart';
import 'baseAuthViewModel.dart';

class LoginViewModel extends BaseAuthViewModel {
  // checkLogin() async {
  //   final User? user = FirebaseAuth.instance.currentUser;
  //   if(user!=null){
  //     MyUser? currentUser=await MyDataBase.getUserById(user.uid??'');
  //     SharedData.userData=currentUser;
  //     navigator?.goToHome();
  //   }
  // }
  Future<void> loginWithEmailAndPassword() async {
    try {
      navigator?.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      print(" this is cerdintaillllllllll id ${credential.user?.uid}");
      emailController.clear();
      passwordController.clear();
      navigator?.hideLoading();
      if (credential.user != null) {
        MyUser? user = await MyDataBase.getUserById(credential.user?.uid ?? '');
        if (user != null) {
          SharedData.userData = user;
          navigator?.goToHome();
        } else {
          navigator?.showMessage("Can't get this User information Now");
        }
      } else {
        navigator?.showMessage("User Credential Error");
      }
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoading();
      if (e.code == 'user-not-found') {
        navigator?.showMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator?.showMessage('Wrong password provided for that user.');
      }
    } catch (e) {
      navigator?.hideLoading();
      navigator?.showMessage(e.toString());
    }
  }
}
