
import 'package:blood/provider/HomeProvider.dart';
import 'package:blood/screens/HomePage.dart';

import 'package:blood/screens/SignUp.dart';
import 'package:blood/screens/Splash.dart';


import 'package:blood/screens/login3.dart';
import 'package:blood/screens/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider())],
      child: MaterialApp(
        home:Splash(),
        routes: {
          '/home': (context)=> HomePage(),
          '/signup' : (context) => SignupPage(),
          '/login3': (context) => LoginPage3(),
          '/profile':(context)=> ProfilePage(),
        },
      ),
    );
  }
}