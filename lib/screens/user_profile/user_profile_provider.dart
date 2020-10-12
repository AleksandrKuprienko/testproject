import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:testproject/models/user.dart' as usr;

class UserProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  User user;
  Map<String, dynamic> userData;

  dynamic client;

  User get currentUser => FirebaseAuth.instance.currentUser;
  String get userDisplayName => client.userName;
  String get userEmail => client.email;
  String get userAvatar => client.avatarUrl;

  void getAuthUser() {
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  Future getUsersData() async {
    try {
      userData = await _firestore
          .collection('users')
          .doc(currentUser.uid)
          .get()
          .then((value) => value.data());
      client = usr.User.fromFirebase(userData);
      return client;
    } catch (e) {
      print(e);
    }
  }

  logOut() async {
    _auth.signOut();
    await _auth.signOut();
  }
}
