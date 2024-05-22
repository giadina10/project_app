


import 'package:blood/provider/HomeProvider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

 
 class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : 
super(key: key);
  static const routename = 'Homepage';
  @override
 Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(HomePage.routename),),

 body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Consumer<HomeProvider>(
                builder: (context, homeProvider, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      homeProvider.getDataOf3Days(homeProvider.showDate1, homeProvider.showDate2);// come si passano le date?
                      print(homeProvider.dati);
              
                final message = homeProvider.dati == null ? 'Request failed' : 'Request successful';
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(SnackBar(content: Text(message)));
              },
              child: Text('REQUEST THE DATA'),
            );
                }
            
            )
          ],
        ),
      ),
    )
    );
  }
 }

 