import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:testproject/models/product.dart';

class ProductProvider with ChangeNotifier {
  bool switcher = false;
  dynamic products;
  final _firestore = FirebaseFirestore.instance;

  Future<List<Product>> getProductsList() async {
    try {
      var snapshot = await _firestore.collection('products').get();
      products =
          snapshot.docs.map((e) => Product.fromFirebase(e.data())).toList();
      return products;
    } catch (e) {
      print(e);
    }
    return products;
  }

  void switchGrid() {
    switcher = !switcher;
    notifyListeners();
  }
}
