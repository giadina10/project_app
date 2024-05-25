import 'package:blood/services/impact2.dart';
import 'package:flutter/material.dart';
import 'package:blood/models/heartrate.dart';
import 'package:blood/models/calories.dart';
import 'package:blood/models/steps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  // Data to be used by the UI
  Map<String, dynamic> dati = {}; // Variable Map returned by the getDataFrom3Days function
  List<HeartRate> heartrates = [];
  List<dynamic> steps = [];
  List<dynamic> calories = [];
  Map<DateTime, int> heartRateMap = {}; // Map to store time-value pairs
  List<DateTime> heartRateTimes = [];
  List<int> heartRateValues = [];
  List<DateTime> caloriesTimes = [];
  List<double> caloriesValues = [];
  List<DateTime> stepsTimes = [];
  List<int> stepsValues = [];

  
  DateTime showDate1 = DateTime.now().subtract(const Duration(days: 3));
  DateTime showDate2 = DateTime.now().subtract(const Duration(days: 1));
  bool isLoading = true; // New variable to track loading state

  final Impact impact = Impact();

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
      for (var heartRate in heartrates) {
        heartRateTimes.add(heartRate.time);
        heartRateValues.add(heartRate.value);
      }
      
      // Extract time and values from steps
      for (var step in steps) {
        stepsTimes.add(step.time);
        stepsValues.add(step.value);
      }
      
      // Extract time and values from calories
      for (var calorie in calories) {
        caloriesTimes.add(calorie.time);
        caloriesValues.add(calorie.value);
      }
      
      print(heartRateTimes);
      print(heartRateValues);
      print(stepsTimes);
      print(stepsValues);
      print(caloriesTimes);
      print(caloriesValues);
    } else {
      print('Error fetching data.');
    }
    
    isLoading = false;
    notifyListeners(); // Notify listeners that loading is finished
  }
}