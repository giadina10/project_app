import 'package:blood/screens/LoginPage.dart';
import 'package:flutter/material.dart';
 class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key}) : 
super(key: key);
  static const routename = 'QuestionPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(QuestionPage.routename),
      ),

 body: Center(
        child: ElevatedButton(
          child: Text('To the HomePage'),
          onPressed: () {
            Navigator.pop(context,MaterialPageRoute<void>(builder: (context)=>LoginPage()));
          },
        ),
 ),
 );
  }
 }