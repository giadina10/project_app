import 'package:blood/provider/HomeProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : 
  super(key: key);
  static const routename = 'ProfilePage';
 @override
 Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: Text(ProfilePage.routename),
      ),
      body: SafeArea(
        child: Center(
          child: Consumer<HomeProvider>(
          builder: (context, provider, child){
            return ElevatedButton(
              child: Text('To the home'),
              onPressed: () {
                //Navigator.pop(context, '/home')
        
                print(provider.dati.keys.last);
                },
             );
          }
          ),
         ),
      ),
 );
 } //build
} //ProfilePage