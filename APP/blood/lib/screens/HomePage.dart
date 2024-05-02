 import 'package:blood/screens/LoginPage.dart';
import 'package:flutter/material.dart';
 class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : 
super(key: key);
  static const routename = 'Homepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(HomePage.routename),
      ),

 body: Center(
        child: ElevatedButton(
          child: Text('Back to the Login Page'),
          onPressed: () {
            Navigator.pop(context,MaterialPageRoute<void>(builder: (context)=>LoginPage()));
          },
        ),
 ),
 );
  }
 }
