import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:testproject/models/user.dart' as usr;

class RegisterProvider with ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  String _email;
  String _password;
  String _name;
  File _image;
  File imageFile;
  String _imageUrl;

  setEmail(String val) => _email = val;
  setPassword(String val) => _password = val;
  setName(String val) => _name = val;
  setImage(File image) {
    _image = image;
    notifyListeners();
  }

  void userRegistration() async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: _email, password: _password);
      _storage
          .ref()
          .child('/userAvatars/${basename(_image.path)}')
          .putFile(File(_image.path))
          .onComplete
          .then((value) => value.ref.getDownloadURL())
          .then((value) {
        _imageUrl = value;
        final user = usr.User(
            uId: result.user.uid,
            email: _email,
            userName: _name,
            avatarUrl: _imageUrl);
        _firestore
            .collection('users')
            .doc(result.user.uid)
            .set(user.toFirebase());
      });

      if (result.user != null) {
        print('Регистрация прошла успешно!');
      }
    } catch (e) {
      print(e);
    }
  }
}
