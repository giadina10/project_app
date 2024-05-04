

import 'package:blood/screens/HomePage.dart';
import 'package:blood/screens/MultiFormPage.dart';
import 'package:blood/screens/QuestionPage.dart';
import 'package:blood/screens/Splash.dart';
import 'package:flutter/material.dart';

import 'package:blood/screens/LoginPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Splash(),
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context)=> HomePage(),
        '/form':(context) => MultiFormPage(),
      },
    );
  }
}

