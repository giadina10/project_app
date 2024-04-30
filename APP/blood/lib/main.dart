 import 'package:flutter/material.dart';
 import 'package:blood/screens/LoginPage.dart';
import 'package:blood/screens/HomePage.dart';
 void main() {
  runApp(const MyApp());
 } //main
 class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      routes: {
      '/Homepage': (context) => HomePage(),
      '/LoginPage':(context) => LoginPage(),
      }
    );
  } //build
 }//MyApp
