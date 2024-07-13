
import 'package:blood/screens/HomePage.dart';
import 'package:blood/screens/signUp_onboarding.dart';
import 'package:blood/services/impact.dart';
import 'package:flutter/material.dart';
import 'package:blood/screens/WelcomePage.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () => _checkLogin(context));
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _startFadeInAnimation());
  }

  void _startFadeInAnimation() {
    setState(() {
      _opacity = 1.0;
    });
  }

  void _toHomePage(BuildContext context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            const HomePage())); //quando i refresh tokens non sono scaduti, vado diretta alla homepage
  } //_toHomePage

  // Method for navigation SplashPage -> LoginPage
  void _toLoginPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => WelcomeScreen())));
  } //_toLoginPage

  void _checkLogin(BuildContext context) async {
    final result = await Impact().refreshTokens();

    final bool isOnboardingCompleted = await checkOnboardingCompletion();
    if (result == 200) {
      if (isOnboardingCompleted) {
        _toHomePage(context);
      } else {
        _toOnboardingPage(context);
      }
    } else {
      _toLoginPage(context);
    }
  }

  Future<bool> checkOnboardingCompletion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool onboardingCompleted = prefs.getBool('onboardingCompleted') ?? false;
    return onboardingCompleted;
  }

  void _toOnboardingPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (context) =>
              const PersonalInfoOnboarding()), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color.fromARGB(255, 240, 175, 175),
          child: Stack(
            children: [
              AnimatedOpacity(
                opacity: _opacity,
                duration: Duration(seconds: 1),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 90),
                      Column(
                        children: [
                          Text(
                            'Welcome to',
                            style: TextStyle(
                                color: Color.fromARGB(255, 121, 8, 0),
                                fontWeight: FontWeight.w100,
                                fontSize: 46,
                                fontFamily: 'PlayfairDisplay'),
                          ),
                          SizedBox(height: 5),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(
                                'assets/images/splashIcon.png',
                                scale: 12,
                              ),
                              SizedBox(width: 5),
                              Text(
                                'Donify',
                                style: TextStyle(
                                  color: Color.fromARGB(255, 121, 8, 0),
                                  fontSize: 40,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'CustomFont',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Image.asset(
                        'assets/images/splash.png',
                        scale: 1,
                      ),
                      Spacer(), // Aggiunge spazio flessibile tra l'immagine e il testo in basso
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: 10), // Aggiunge un padding inferiore
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            'Donify Version 1.0',
                            style: TextStyle(
                              color: Color.fromARGB(255, 121, 8, 0),
                              fontSize: 14,
                            ),
                          ),
                        ),
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
