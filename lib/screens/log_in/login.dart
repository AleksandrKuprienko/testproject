import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:testproject/constants.dart';
import 'package:testproject/screens/product/product.dart';
import 'package:testproject/screens/log_in/login_provider.dart';
import 'package:testproject/screens/product/product_provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    LogInProvider _provider = Provider.of<LogInProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Вход',
        ),
        elevation: 0,
      ),
      body: Padding(
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
            SizedBox(height: 15),
            OutlineButton(
              onPressed: () async {
                try {
                  _provider.signWithEmailAndPassword().then((value) => {
                        if (value != null)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ChangeNotifierProvider<ProductProvider>(
                                  create: (_) => ProductProvider(),
                                  child: ProductScreen(),
                                ),
                              ),
                            )
                          }
                        else
                          {print('Введите данные пользователя')}
                      });
                } catch (e) {
                  print('error on login_screen');
                }
              },
              highlightColor: Colors.blue,
              splashColor: Colors.blue,
              child: Text('Войти'),
            ),
            SizedBox(height: 35),
            OutlineButton.icon(
              icon: Icon(Icons.verified_user),
              label: Text('Войти через Google'),
              highlightColor: Colors.blue,
              splashColor: Colors.green,
              onPressed: () {
                _provider.signInWithGoogle().then((value) => {
                      if (value != null)
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ChangeNotifierProvider<ProductProvider>(
                                create: (_) => ProductProvider(),
                                child: ProductScreen(),
                              ),
                            ),
                          ),
                        }
                      else
                        {showDefaultSnackbar(context)}
                    });
              },
            )
          ],
        ),
      ),
    );
  }
}

void showDefaultSnackbar(BuildContext context) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content: Text('Введите данные пользователя'),
    action: SnackBarAction(label: 'hehe', onPressed: null),
  ));
}
