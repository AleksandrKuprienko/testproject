import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInProvider with ChangeNotifier {
  FirebaseAuth _auth = FirebaseAuth.instance;

  String _email;
  String _password;

  setEmail(String val) => _email = val;
  setPassword(String val) => _password = val;

  Future<UserCredential> signWithEmailAndPassword() async {
    UserCredential result;
    try {
      final user = await _auth.signInWithEmailAndPassword(
          email: _email, password: _password);
      if (user != null) {
        print('Вход прошел успешно!');
        print(user.user.uid);
        return result = user;
      } else {
        print('Вход через почту пароль не удался');
      }
    } catch (e) {
      print('Ошибка при входе login_provider');
    }
    return result;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
