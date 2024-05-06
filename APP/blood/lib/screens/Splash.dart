

import 'package:flutter/material.dart';
import 'package:blood/screens/WelcomePage.dart';
import 'dart:async';
//import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget{
 const Splash({Key? key}) : super(key:key);
  @override
  _SplashState createState()=>_SplashState();
}

class _SplashState extends State<Splash>{

  @override
  void initState(){
    super.initState();
    _navigatetoHome(context);
  }

  void _navigatetoHome(context)async{
    await Future.delayed(Duration(seconds: 3),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context,) => WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor:Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 240,
                  decoration: BoxDecoration(color: Color.fromARGB(255, 31, 78, 107),
                  borderRadius: 
                  BorderRadius.only(
                    bottomLeft: Radius.circular(20), 
                    bottomRight: Radius.circular(20),
                     )
                  ),
                ),
                
              ]
            )

        ],)
      ,),
      
    );
  }
}