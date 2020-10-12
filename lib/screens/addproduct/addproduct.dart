import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:testproject/screens/product/product.dart';
import 'package:testproject/constants.dart';

import 'package:provider/provider.dart';
import 'package:testproject/screens/addproduct/addproduct_provider.dart';

class AddProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddProducProvider _provider = Provider.of<AddProducProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Добавить продукт'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              onChanged: (String val) => _provider.setTitle(val),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Название'),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (String val) => _provider.setDescription(val),
              maxLength: 100,
              maxLines: 2,
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Описание'),
            ),
            SizedBox(height: 10),
            TextField(
              onChanged: (String val) => _provider.setPrice(val),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              textAlign: TextAlign.center,
              decoration: kTextFieldDecoration.copyWith(hintText: 'Цена'),
            ),
            SizedBox(height: 3),
            FlatButton(
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.red,
                  width: 1,
                  style: BorderStyle.solid,
                ),
              ),
              onPressed: () async {
                final _imagePicker = ImagePicker();
                final image = await _imagePicker
                    .getImage(source: ImageSource.gallery)
                    .catchError((err) {
                  print(err);
                });
                if (image != null) {
                  _provider.imageFile = _provider.setImage(File(image.path));
                } else {
                  print('Добавление изображения отменено');
                }
                print('Изображение добавлено');
              },
              child: Text('Прикрепить изображение'),
            ),
            SizedBox(height: 20),
            OutlineButton(
              onPressed: () {
                _provider.addProduct();
                Navigator.pop(
                  context,
                  MaterialPageRoute(builder: (context) => ProductScreen()),
                );
              },
              highlightColor: Colors.blue,
              splashColor: Colors.blue,
              child: Text('Добавить'),
            ),
          ],
        ),
      ),
    );
  }
}
