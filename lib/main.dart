import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:testproject/screens/welcome/welcome.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: Future.delayed(
          Duration(seconds: 2),
          () => Firebase.initializeApp(),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return WelcomeScreen();
          if (snapshot.hasError) return Text(snapshot.error);
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
