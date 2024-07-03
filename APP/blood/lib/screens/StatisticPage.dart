import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blood/provider/HomeProvider.dart';
import 'package:blood/models/heartrate.dart';
import 'package:blood/models/calories.dart';
import 'package:blood/models/steps.dart';
import 'package:blood/utils/plotSteps.dart';
import 'package:blood/utils/plotCalories.dart';
import 'package:blood/utils/plotHeartRate.dart'; // Import del nuovo widget PlotHeartRate

class Stats extends StatelessWidget {
  const Stats(this.provider, {Key? key}) : super(key: key);

  static const routename = 'Stats';
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    List<Steps> steps = provider.steps;
    List<Calories> calories = provider.calories;
    List<HeartRate> heartRates = provider.heartrates; // Recupero dei dati del battito cardiaco

    // Calcolo della media dei valori di Heart Rate
    double averageHeartRate(List<HeartRate> heartRates) {
      if (heartRates.isEmpty) return 0;

      int sum = heartRates.map((heartRate) => heartRate.value).reduce((a, b) => a + b);
      return sum / heartRates.length;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Personal Statistics',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Container per il plot degli steps
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 186, 235, 232), width: 3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: 200,
                child: StepDataPlot(stepData: steps),
              ),
            ),
            // Container per il plot delle calorie
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color:Color.fromARGB(255, 186, 235, 232), width: 3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: 200,
                child: CaloriesPlot(caloriesData: calories),
              ),
            ),
            // Container per la media dei battiti cardiaci
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromARGB(255, 186, 235, 232), width: 3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  Text(
                    'Average Heart Rate',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    averageHeartRate(heartRates).toStringAsFixed(1), // Mostra la media con una cifra decimale
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
            ),
           
          
          ],
        ),
      ),
    );
  }
}
