import 'package:blood/screens/LoginPage.dart';
import 'package:flutter/material.dart';
 class QuestionPage extends StatelessWidget {
  const QuestionPage({Key? key}) : 
super(key: key);
  static const routename = 'QuestionPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[300],
      body:SafeArea(
        child:Stack(
          children:[
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height:240,
                  decoration: BoxDecoration(
                    color:Color.fromARGB(45,200 , 106, 120),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25),
                    ),
                ),
                ),
              ],
            ),
          ]
        )
      )
    );
  }
 }

