import 'package:flutter/material.dart';

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

body: Center(
 child: ElevatedButton(
 child: Text('To the home'),
 onPressed: () {
 },
 ),
 ),
 );
 } //build
} //ProfilePage