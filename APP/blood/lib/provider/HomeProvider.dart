

import 'package:blood/services/impact2.dart';
import 'package:flutter/material.dart';
import 'package:blood/models/heartrate.dart';
import 'package:blood/models/calories.dart';
import 'package:blood/models/steps.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:blood/utils/algorithm.dart';




class HomeProvider extends ChangeNotifier {
  // Data to be used by the UI
  Map<String, dynamic> dati = {}; // Variable Map returned by the getDataFrom3Days function
  List<HeartRate> heartrates = [];
  List<Steps> steps = [];
  List<Calories> calories = [];
  DateTime showDate1 = DateTime.now().subtract(const Duration(days: 3));
  DateTime showDate2 = DateTime.now().subtract(const Duration(days: 1));
  bool isLoading = true; // New variable to track loading state
  int num = 3; //per algoritmo
  
  String risultatoalgoritmo = "" ;

  late SharedPreferences sp;
  final Impact impact = Impact();
  late Algorithm algoritmo;
  

  HomeProvider() {
    init(); //l'inizializzazione è asincrona e getdata non prende le prefernze
    getData(showDate1, showDate2,num);
  }

void init() async {
 await getPreferences();
 algoritmo = Algorithm(sp); 
}
   Future<void> getPreferences() async {
    sp = await SharedPreferences.getInstance();
     risultatoalgoritmo = sp.getString('algoritmo_result') ?? "";  // Carica il risultato salvato //da CONTROLLARE (inserita il 10-06-24)
     notifyListeners();
  }

  void getData(DateTime showDate1, DateTime showDate2,num) async {
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
      

      risultatoalgoritmo= await algoritmo.decisionTree(heartrates,calories,steps,num); //DA CONTROLLARE (inserita il 10.06.24)
     
      print('QUESTE SONO LE DATEEEEEE');
      print(showDate1);
      print(showDate2);
     
    } else {
      print('Error fetching data.');
    }

    isLoading = false;
    notifyListeners(); // Notify listeners that loading is finished
  }
}