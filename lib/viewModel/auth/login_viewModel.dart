import 'package:firebase_auth/firebase_auth.dart';

import 'baseAuthViewModel.dart';

class LoginViewModel extends BaseAuthViewModel {
  Future<void> loginWithEmailAndPassword() async {
    try {
      navigator?.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      emailController.text = '';
      passwordController.text = '';
      navigator?.hideLoading();
      navigator?.showMessage('${credential.user?.uid}');
    } on FirebaseAuthException catch (e) {
      navigator?.hideLoading();
      if (e.code == 'user-not-found') {
        navigator?.showMessage('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        navigator?.showMessage('Wrong password provided for that user.');
      }
    } catch (e) {
      navigator?.showMessage(e.toString());
    }
  }
}
