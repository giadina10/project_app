

import 'package:blood/services/impact.dart';
import 'package:flutter/material.dart';
import 'package:blood/models/heartrate.dart';
import 'package:blood/models/calories.dart';
import 'package:blood/models/steps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blood/utils/algorithm.dart';




class HomeProvider extends ChangeNotifier {
 
  Map<String, dynamic> dati = {}; 
  List<HeartRate> heartrates = [];
  List<Steps> steps = [];
  List<Calories> calories = [];
  DateTime showDate1 = DateTime.now().subtract(const Duration(days: 3));
  DateTime showDate2 = DateTime.now().subtract(const Duration(days: 1));
  bool isLoading = true; 
  int num = 3; //per algoritmo
  
  String risultatoalgoritmo = "" ;

  late SharedPreferences sp;
  final Impact impact = Impact();
  late Algorithm algoritmo;
  

  HomeProvider() {
    init(); 
  
  }

void init() async {
 await getPreferences();
 algoritmo = Algorithm(sp); 
}
   Future<void> getPreferences() async {
    sp = await SharedPreferences.getInstance();
     risultatoalgoritmo = sp.getString('algoritmo_result') ?? "";  // Carica il risultato salvato 
     notifyListeners();
  }

  void getData(DateTime showDate1, DateTime showDate2,num) async {
    isLoading = true;
    notifyListeners(); 

    final fetchedData = await impact.getDataFrom3Days(showDate1, showDate2);
    if (fetchedData != null) {
      dati = fetchedData;
     
      
      heartrates = dati['heartRates'];
      steps = dati['steps'];
      calories = dati['calories'];
      
      

      risultatoalgoritmo= await algoritmo.decisionTree(heartrates,calories,steps,num); 
     
     
     
    } else {
      print('Error fetching data.');
    }

    isLoading = false;
    notifyListeners(); 
  }
}