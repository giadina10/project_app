import 'package:blood/provider/FeaturesProvider.dart';
import 'package:blood/screens/BloodDonorCenterPage.dart';
import 'package:blood/screens/HomePage.dart';
import 'package:blood/screens/SignUp.dart';
import 'package:blood/screens/SignUp_onboarding.dart';
import 'package:blood/screens/Splash.dart';
import 'package:blood/screens/TermsofUsePage.dart';
import 'package:blood/screens/activity_levelpage.dart';
import 'package:blood/screens/login.dart';
import 'package:blood/screens/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() {
  runApp(
    ChangeNotifierProvider( //se sono più provider, meglio usare MultiProvider. nel nostro caso è solo uno.
      create: (_) => FeaturesProvider(), //inizializzo nuovo provider per gestire le shared preferences
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
        '/profile': (context) => Profile(),
        '/bloodDonorCenter':(context)=>BloodDonorCenterPage(),
        '/TermsOfUse':(context)=>TermsOfUsePage(),
        '/activitylevelpage':(context)=>ActivityLevelPage(),
      },
    );
  }
}