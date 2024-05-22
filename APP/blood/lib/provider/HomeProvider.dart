import 'dart:math';

import 'package:blood/services/impact2.dart';
import 'package:flutter/material.dart';
import 'package:blood/models/heartrate.dart';
import 'package:blood/models/calories.dart';
import 'package:blood/models/steps.dart';
import 'package:shared_preferences/shared_preferences.dart';


// this is the change notifier. it will manage all the logic of the home page: fetching the correct data from the online services
class HomeProvider extends ChangeNotifier {
  // data to be used by the UI
  Map<String,List> dati = {}; //variabile Map ritornata dalla funzione getDataFrom3Days
  //queste tre liste ci servono per dividere i dati ottenuti
  List<HeartRate> heartrates = [];
  List<Steps> steps = [];
  List<Calories> calories = [];
  String nick = 'User';
  // data range (intervallo di 3 giorni)
  DateTime showDate1 = DateTime.now().subtract(const Duration(days: 1));
  DateTime showDate2 = DateTime.now().subtract(const Duration(days: 4));
  //tolgo le ore e trasformo in stringa


  // data generators with external services
  final Impact impact = Impact();


  // Algorithm class (ancora da definire)
 // final Algorithmms algorithm = Algorithmms(1);

  // constructor of provider which manages the fetching of all data from the servers and then notifies the ui to build
  HomeProvider() {
    getDataOf3Days(showDate1,showDate2); //manca una variabile
  }

  // method to get the data of the chosen range of data
  void getDataOf3Days(DateTime showDate1, DateTime showDate2) async {
      //tolgo le ore e trasformo in stringa 
    String Date2= showDate2.toString().substring(0, 10); // Output: 'YYYY-MM-DD'
    String Date1= showDate1.toString().substring(0, 10);

    //invoco funzione per ottenere i dati
    
    // Invoca la funzione per ottenere i dati
  dati = (await Impact().getDataFrom3Days(showDate1, showDate2))!;

  // TODO Estrai i dati di cuore, passi e calorie


    
    // after selecting all data we notify all consumers to rebuild
    notifyListeners();
  }


 

}