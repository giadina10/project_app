import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) :super(key: key);
  static const routename = 'WelcomePage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text(WelcomePage.routename),
      )
    );
  }
}
