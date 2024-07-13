import 'package:blood/provider/FeaturesProvider.dart';
import 'package:blood/screens/BloodDonorCenterPage.dart';
import 'package:blood/screens/HomePage.dart';
import 'package:blood/screens/SignUp.dart';
import 'package:blood/screens/signUp_onboarding.dart';
import 'package:blood/screens/Splash.dart';
import 'package:blood/screens/TermsofUsePage.dart';
import 'package:blood/screens/activity_levelpage.dart';
import 'package:blood/screens/login.dart';
import 'package:blood/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    ChangeNotifierProvider( 
      create: (_) => FeaturesProvider(), 
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
      routes: {
        '/home': (context) => HomePage(),
        '/signup_onboarding': (context) => PersonalInfoOnboarding(),
        '/signup': (context) => PersonalInfo(),
        '/login3': (context) => LoginPage(),
        '/settings': (context) => Settings(),
        '/bloodDonorCenter':(context)=>BloodDonorCenterPage(),
        '/TermsOfUse':(context)=>TermsOfUsePage(),
        '/activitylevelpage':(context)=>ActivityLevelPage(),
      },
    );
  }
}