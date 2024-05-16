

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:blood/screens/WelcomePage.dart';
import 'dart:async';

import 'package:lottie/lottie.dart';
//import 'package:shared_preferences/shared_preferences.dart';

class CustomWaveDecoration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.redAccent // Colore dell'ondulazione
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, size.height * 0.9) // Inizia il percorso dalla sinistra al centro
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.5, size.width * 0.5, size.height * 0.6) // Onda sinistra
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.7, size.width, size.height * 0.6) // Onda destra
      ..lineTo(size.width, 0) // Linea verticale verso l'alto
      ..lineTo(0, 0) // Linea orizzontale verso sinistra
      ..close(); // Chiude il percorso

    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}


class Splash extends StatefulWidget{
 const Splash({Key? key}) : super(key:key);
  @override
  _SplashState createState()=>_SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin{
  
  double _opacity = 0.0; //t

  @override
  void initState(){
    super.initState();
    _startFadeInAnimation(); //t
    _navigatetoHome(context);
  }

//t funzione
  void _startFadeInAnimation() {
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  void _navigatetoHome(context)async{
    await Future.delayed(Duration(seconds: 3),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context,) => WelcomeScreen()));
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            size: Size(MediaQuery.of(context).size.width, 150),
            painter: CustomWaveDecoration(),
          ),
          AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(seconds: 2),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'assets/images/splashIcon.png',
                        scale: 8,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Donify',
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'CustomFont',
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
