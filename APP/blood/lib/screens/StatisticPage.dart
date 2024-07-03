import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Importa intl per utilizzare DateFormat
import 'package:provider/provider.dart';
import 'package:blood/provider/HomeProvider.dart';
import 'package:blood/models/steps.dart';
import 'package:blood/models/calories.dart';
import 'package:blood/models/heartrate.dart'; // Importa il modello HeartRate

class Stats extends StatelessWidget {
  const Stats(this.provider, {Key? key}) : super(key: key);

  static const routename = 'Stats';
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    List<Steps> steps = provider.steps;
    List<Calories> calories = provider.calories;
    List<HeartRate> heartRates = provider.heartrates; // Ottieni la lista di HeartRate dal provider

    // Raggruppa i passi per giorno
    Map<String, int> totalStepsByDay = {};
    for (Steps step in steps) {
      String dayKey = DateFormat('yyyy-MM-dd').format(step.time);
      totalStepsByDay[dayKey] = (totalStepsByDay[dayKey] ?? 0) + step.value;
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
        title: const Text(
          'Data',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 240, 175, 175), // Sfondo azzurrino
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

            return ListTile(
              leading: Icon(Icons.timeline),
              title: Text('Date: $day'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total Steps: $stepsCount'),
                  Text('Total Calories: ${caloriesCount.toStringAsFixed(2)}'), // Tronca a due cifre decimali
                  if (heartRatesForDay != null)
                    Text('Average Heart Rate: ${averageHeartRate.toStringAsFixed(1)} bpm'), // Tronca a una cifra decimale
                ],
              ),
              onTap: () {
                // Azioni quando viene selezionato un elemento della lista
              },
            );
          },
        ),
      ),
    );
  }
}
