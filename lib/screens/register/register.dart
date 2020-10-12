import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

import 'package:testproject/constants.dart';
import 'package:testproject/screens/product/product.dart';
import 'package:testproject/screens/product/product_provider.dart';
import 'package:testproject/screens/register/register_provider.dart';

//COMMENT: регистрация (почта, пароль, имя, фото)

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegisterProvider _provider = Provider.of<RegisterProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Регистрация'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (String val) => _provider.setEmail(val),
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Введите email'),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (String val) => _provider.setPassword(val),
                  textAlign: TextAlign.center,
                  obscureText: true,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Введите пароль'),
                ),
                SizedBox(height: 10),
                TextField(
                  onChanged: (String val) => _provider.setName(val),
                  textAlign: TextAlign.center,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Введите имя'),
                ),
                SizedBox(height: 5),
                FlatButton(
                  color: Colors.orange,
                  highlightColor: Colors.blue,
                  splashColor: Colors.red,
                  onPressed: () async {
                    final _imagePicker = ImagePicker();
                    final image = await _imagePicker
                        .getImage(source: ImageSource.gallery)
                        .catchError((err) {
                      print(err);
                    });
                    if (image != null) {
                      _provider.imageFile =
                          _provider.setImage(File(image.path));
                    } else {
                      print('Добавление фото отменено');
                    }
                  },
                  child: Text('Прикрепить фото'),
                ),
                SizedBox(height: 15),
                OutlineButton(
                  onPressed: () {
                    _provider.userRegistration();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<ProductProvider>(
                          create: (_) => ProductProvider(),
                          child: ProductScreen(),
                        ),
                      ),
                    );
                  },
                  highlightColor: Colors.blue,
                  splashColor: Colors.blue,
                  child: Text('Зарегистрироваться'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
