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
    return Scaffold(
      appBar: AppBar(
        title: Text(ProfilePage.routename),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              _toLogin(context);
             
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Consumer<HomeProvider>(
            builder: (context, provider, child) {
              return ElevatedButton(
                child: Text('To the home'),
                onPressed: () {
                  // Navigator.pop(context, '/home');
                  print(provider.dati.keys.last);
                },
              );
            },
          ),
        ),
      ),
    );
  } // build

  _toLogin(BuildContext context) async {
    final sp = await SharedPreferences.getInstance();

    // opt 1: remove specific keys
    // await sp.remove("age");
    // await sp.remove("gender");
    // await sp.remove("username");
    // await sp.remove("password");

    // opt 2: clear whole shared prefs
    await sp.clear();
    //Then pop the HomePage
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => const LoginPage3())));
  }
} // ProfilePage