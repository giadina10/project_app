import 'dart:ffi';

import 'package:blood/services/impact2.dart';
import 'package:blood/utils/plot.dart';
import 'package:flutter/material.dart';
import 'package:blood/models/heartrate.dart';
import 'package:blood/models/calories.dart';
import 'package:blood/models/steps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blood/utils/algorithm.dart';
import 'package:blood/utils/plot.dart';



class HomeProvider extends ChangeNotifier {
  // Data to be used by the UI
  Map<String, dynamic> dati = {}; // Variable Map returned by the getDataFrom3Days function
  List<HeartRate> heartrates = [];
  List<Steps> steps = [];
  List<Calories> calories = [];
  DateTime showDate1 = DateTime.now().subtract(const Duration(days: 3));
  DateTime showDate2 = DateTime.now().subtract(const Duration(days: 1));
  bool isLoading = true; // New variable to track loading state
  
  String risultatoalgoritmo = "" ;


  final Impact impact = Impact();
  final Algorithm algoritmo = Algorithm();
  //final CustomPlot plot ;

  HomeProvider() {
    getData(showDate1, showDate2);
  }

  void getData(DateTime showDate1, DateTime showDate2) async {
    isLoading = true;
    notifyListeners(); // Notify listeners that loading is starting

    final fetchedData = await impact.getDataFrom3Days(showDate1, showDate2);
    if (fetchedData != null) {
      dati = fetchedData;
       // Directly assign data
      
      heartrates = dati['heartRates'];
      steps = dati['steps'];
      calories = dati['calories'];
      //visto che non dovrebbero esserci valori null, procediamo con la divisione dei dati in liste (tempo) e lista (valore)
      // Extract time and values from heartRates
      

      risultatoalgoritmo=algoritmo.decisionTree(heartrates,calories,steps);
      
     
    } else {
      print('Error fetching data.');
    }

    isLoading = false;
    notifyListeners(); // Notify listeners that loading is finished
  }
}