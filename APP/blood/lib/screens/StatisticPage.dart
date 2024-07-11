import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:blood/provider/HomeProvider.dart';
import 'package:blood/models/steps.dart';
import 'package:blood/models/calories.dart';
import 'package:blood/models/heartrate.dart';

class Stats extends StatelessWidget {
  const Stats(this.provider, {Key? key}) : super(key: key);

  static const routename = 'Stats';
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    List<Steps> steps = provider.steps;
    List<Calories> calories = provider.calories;
    List<HeartRate> heartRates = provider.heartrates;

    // Raggruppa i passi per giorno
    Map<String, int> totalStepsByDay = {};
    for (Steps step in steps) {
      String dayKey = DateFormat('yyyy-MM-dd').format(step.time);
      totalStepsByDay[dayKey] = (totalStepsByDay[dayKey] ?? 0) + step.value;
    }

    // Calcola la media dei passi per i giorni diversi da zero
    double averageSteps = 0;
    int totalDaysWithSteps = 0;
    totalStepsByDay.forEach((day, stepsCount) {
      if (stepsCount > 0) {
        averageSteps += stepsCount;
        totalDaysWithSteps++;
      }
    });
    if (totalDaysWithSteps > 0) {
      averageSteps /= totalDaysWithSteps;
    }

    // Raggruppa le calorie per giorno
    Map<String, double> totalCaloriesByDay = {};
    for (Calories calorie in calories) {
      String dayKey = DateFormat('yyyy-MM-dd').format(calorie.time);
      totalCaloriesByDay[dayKey] = (totalCaloriesByDay[dayKey] ?? 0) + calorie.value;
    }

    // Raggruppa i battiti cardiaci per giorno
    Map<String, List<HeartRate>> heartRatesByDay = {};
    for (HeartRate heartRate in heartRates) {
      String dayKey = DateFormat('yyyy-MM-dd').format(heartRate.time);
      if (!heartRatesByDay.containsKey(dayKey)) {
        heartRatesByDay[dayKey] = [];
      }
      heartRatesByDay[dayKey]!.add(heartRate);
    }

    // Unisci le chiavi di giorni da tutti i raggruppamenti
    Set<String> allDays = {
      ...totalStepsByDay.keys,
      ...totalCaloriesByDay.keys,
      ...heartRatesByDay.keys,
    };
    List<String> sortedDays = allDays.toList()
      ..sort((a, b) => DateFormat('yyyy-MM-dd').parse(a).compareTo(DateFormat('yyyy-MM-dd').parse(b)));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 240, 175, 175),
        centerTitle: true,
        title: const Text(
          'Your statistics',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 175, 175),
        ),
        child: ListView.builder(
          itemCount: sortedDays.length,
          itemBuilder: (context, index) {
            String day = sortedDays[index];
            int stepsCount = totalStepsByDay[day] ?? 0;
            double caloriesCount = totalCaloriesByDay[day] ?? 0;
            List<HeartRate>? heartRatesForDay = heartRatesByDay[day];

            // Calcola la media dei battiti cardiaci per il giorno corrente
            double averageHeartRate = 0;
            if (heartRatesForDay != null && heartRatesForDay.isNotEmpty) {
              int sum = heartRatesForDay.map((hr) => hr.value).reduce((a, b) => a + b);
              averageHeartRate = sum / heartRatesForDay.length;
            }

            // Sostituisci i passi 0 con la media totale dei passi
            if (stepsCount == 0 && totalDaysWithSteps > 0) {
              stepsCount = averageSteps.toInt();
            }

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 5.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: Icon(Icons.timeline),
                title: Text('Date: $day', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Steps: $stepsCount'),
                    Text('Total Calories: ${caloriesCount.toStringAsFixed(2)} kcal'),
                    if (heartRatesForDay != null)
                      Text('Average Heart Rate: ${averageHeartRate.toStringAsFixed(1)} bpm'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
