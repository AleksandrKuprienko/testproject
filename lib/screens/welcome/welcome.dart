import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:testproject/screens/log_in/login.dart';
import 'package:testproject/screens/log_in/login_provider.dart';
import 'package:testproject/screens/register/register.dart';
import 'package:testproject/screens/register/register_provider.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OutlineButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider<LogInProvider>(
                      create: (_) => LogInProvider(),
                      child: LoginScreen(),
                    ),
                  ),
                );
              },
              highlightColor: Colors.blue,
              splashColor: Colors.blue,
              child: Text('Вход'),
            ),
            SizedBox(height: 10),
            OutlineButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider<RegisterProvider>(
                      create: (_) => RegisterProvider(),
                      child: RegisterScreen(),
                    ),
                  ),
                );
              },
              highlightColor: Colors.blue,
              splashColor: Colors.blue,
              child: Text('Регистрация'),
            ),
          ],
        ),
      ),
    );
  }
}
