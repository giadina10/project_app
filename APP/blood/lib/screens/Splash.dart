//import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:blood/screens/HomePage.dart';
import 'package:blood/screens/SignUp.dart';
import 'package:blood/screens/login3.dart';
import 'package:blood/services/impact2.dart';
import 'package:flutter/material.dart';
import 'package:blood/screens/WelcomePage.dart';
import 'dart:async';

//import 'package:shared_preferences/shared_preferences.dart';

class CustomWaveDecoration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color.fromARGB(255, 241, 173, 152) // Colore dell'ondulazione
      ..style = PaintingStyle.fill;
    final Path path = Path()
      ..moveTo(0, size.height * 0.25) // Inizia in basso a sinistra
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.75,
          size.width * 0.5, size.height * 0.5) // Prima curva
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.25, size.width,
          size.height * 0.75) // Seconda curva
      ..lineTo(size.width, 0) // Linea verso l'alto a destra
      ..lineTo(0, 0) // Linea verso sinistra in basso
      ..close(); // Chiude il percorso

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class CustomBottomWaveDecoration extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Color.fromARGB(255, 241, 173, 152) // Colore dell'ondulazione
      ..style = PaintingStyle.fill;

    final Path path = Path()
      ..moveTo(0, size.height) // Inizia in basso a sinistra
      ..quadraticBezierTo(size.width * 0.25, size.height * 0.25,
          size.width * 0.5, size.height * 0.5) // Prima curva
      ..quadraticBezierTo(size.width * 0.75, size.height * 0.75, size.width,
          size.height * 0.25) // Seconda curva
      ..lineTo(size.width, size.height) // Linea verso il basso a destra
      ..lineTo(0, size.height) // Linea verso sinistra in basso
      ..close(); // Chiude il percorso

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  double _opacity = 0.0; //t

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () => _checkLogin(context));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _startFadeInAnimation()); //t/
    // _navigatetoHome(context);
  }

//t funzione
  void _startFadeInAnimation() {
    // Future.delayed(Duration(milliseconds: 500), () {
    setState(() {
      _opacity = 1.0;
    });
    //  });
  }

  //3 funzioni inserite ora (17.05)
  void _toHomePage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const PersonalInfo()));
  } //_toHomePage

  // Method for navigation SplashPage -> LoginPage
  void _toLoginPage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: ((context) =>
            WelcomeScreen()))); //TODO: cambiare a loginpage3!!!!
  } //_toLoginPage

  void _checkLogin(BuildContext context) async {
    final result = await Impact().refreshTokens();
    //final result = 400; // DA RIMUOVERE: utile SOLO in fase di check codice per vedere anche login e welcome. SCOMMMENTA RIGA SOPRA PER RISOLVERE +
    if (result == 200) {
      _toHomePage(context);
    } else {
      _toLoginPage(context);
    }
  } //_checkLogin
//questa funzione è nostra
  //void _navigatetoHome(context)async{
  // await Future.delayed(Duration(seconds: 3),(){});
  //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context,) => WelcomeScreen()));
  //}

  @override
  Widget build(BuildContext context) {
    //aggiunta ora la prossima riga
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: const Color.fromARGB(255, 241, 96, 85),
          child: Stack(
            children: [
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width, 150),
                painter: CustomWaveDecoration(),
              ),
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Spacer(flex: 2),
                       Column(
                        children: [
                          Text(
                            'Welcome to',
                            style: TextStyle(
                                fontSize: 46,
                                fontFamily: 'PlayfairDisplay'),
                          ),
                          SizedBox(height: 5), // Aggiungi spazio tra la scritta "Welcome to" e l'icona
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/splashIcon.png',
                                scale: 12,
                              ),
                              SizedBox(width: 5), // Aggiungi spazio tra l'icona e il testo "Donify"
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
                        ],
                      ),

                      SizedBox(
                          height: 20), // Spazio tra la riga e l'immagine sotto
                      Image.asset(
                        'assets/images/splash.png',
                        scale: 1,
                      ),
                      CustomPaint(
                        size: Size(MediaQuery.of(context).size.width, 150),
                        painter: CustomBottomWaveDecoration(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
