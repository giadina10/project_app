
import 'package:blood/screens/LoginPage.dart';
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
            Image(image: AssetImage('assets/images/welcome.png'),
            height: 150,
            width: 400,
            alignment: Alignment.center),
            Text('Sangue'),
          ]
        ),
      )
    );
  }
}