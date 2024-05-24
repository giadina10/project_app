import 'package:blood/screens/profilePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blood/provider/HomeProvider.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static const String routeName = 'Homepage';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => HomeProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Impact Data'),
        ),
        body: Consumer<HomeProvider>(
          builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Ho preso i dati!'),
                   ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: const Text('Go to Profile Page'),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}