import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Stats extends StatelessWidget {
  const Stats({Key? key}) : super(key: key);
  static const routename = 'Stats';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Stats.routename),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('To the Home Page'),
          onPressed: () {
            Navigator.pushNamed(context, '/home'); // Assumi che 'Homepage' sia la rotta per la home page
          },
        ),
      ),
    );
  } // build
}
