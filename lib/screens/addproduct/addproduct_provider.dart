import 'dart:io';
import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';
import 'package:testproject/models/product.dart';

class AddProducProvider with ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  String _title;
  String _description;
  String _price;
  File _image;
  File imageFile;
  String _imageFile;

  setTitle(String val) => _title = val;
  setDescription(String val) => _description = val;
  setPrice(String val) => _price = val;
  setImage(File image) {
    _image = image;
    notifyListeners();
  }

  void addProduct() {
    try {
      _storage
          .ref()
          .child('/productImages/${basename(_image.path)}')
          .putFile(File(_image.path))
          .onComplete
          .then((value) => value.ref.getDownloadURL())
          .then((value) {
        _imageFile = value;
        final product = Product(
            title: _title,
            description: _description,
            imageUrl: _imageFile,
            price: _price);
        _firestore.collection('products').add(product.toFirebase());
      });
      print('Добавили');
    } catch (e) {
      print(e);
    }
  }
}
