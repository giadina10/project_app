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
  List<Steps> steps = [];
  List<Calories> calories = [];
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
     
    } else {
      print('Error fetching data.');
    }

    isLoading = false;
    notifyListeners(); // Notify listeners that loading is finished
  }
}