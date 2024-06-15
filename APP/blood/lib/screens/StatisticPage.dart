import 'package:blood/models/heartrate.dart';
import 'package:blood/models/calories.dart';
import 'package:blood/models/steps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blood/provider/HomeProvider.dart';
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

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Daily Personal Statistics',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container per il plot degli steps
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.redAccent, width: 3),
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
                border: Border.all(color: Colors.blueAccent, width: 3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: 200,
                child: CaloriesPlot(caloriesData: calories),
              ),
            ),
            // Container per il plot dei battiti cardiaci
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.greenAccent, width: 3),
                borderRadius: BorderRadius.circular(15),
              ),
              child: SizedBox(
                height: 200,
                child: HeartRatePlot(heartRateData: heartRates),
              ),
            ),
            // Aggiungere contenuto aggiuntivo sotto il plot
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Additional content goes here.',
                style: TextStyle(fontSize: 18),
              ),
            ),
            // Aggiungere altri widget o contenuti se necessario
          ],
        ),
      ),
    );
  }
}
