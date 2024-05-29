

import 'package:blood/screens/HomePage.dart';
import 'package:blood/screens/SignUp.dart';
import 'package:blood/screens/Splash.dart';
import 'package:blood/screens/login3.dart';
import 'package:blood/screens/profilePage.dart';
import 'package:flutter/material.dart';



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
          '/home': (context)=> HomePage(),
          '/signup' : (context) => PersonalInfo(),
          '/login3': (context) => LoginPage3(),
          '/profile':(context)=> ProfilePage(),
         
        },
      );
    
  }
}