import 'package:flutter/material.dart';
import 'package:blood/services/impact.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiFormPage extends StatefulWidget {
  const MultiFormPage({Key? key}) : super(key: key);

  @override
  _MultiFormPagestate createState() => _MultiFormPagestate();
}

class _MultiFormPagestate extends State<MultiFormPage> {
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 240, // Altezza desiderata del Container
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(45, 200, 106, 120),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}