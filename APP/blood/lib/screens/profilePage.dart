import 'package:blood/provider/HomeProvider.dart';
import 'package:blood/screens/login3.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static const routename = 'ProfilePage';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
         child : Center(
          child: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return ElevatedButton(
                child: const Text('To the home'),
                onPressed: () {
                  print(provider.dati.keys.last);
                },
              );
            },
          ),
        ),
      );
    
  }

  _toLogin(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    await sp.clear();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => const LoginPage3())));
  }
}