import 'package:blood/models/calories.dart';
import 'package:blood/models/steps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blood/provider/HomeProvider.dart';
import 'package:blood/utils/plotSteps.dart'; // Adjust the import according to your folder structure
import 'package:blood/utils/plotCalories.dart'; // Import del nuovo widget PlotCalories

class Stats extends StatelessWidget {
  const Stats(this.provider,{ Key? key}) : super(key: key);
  
  static const routename = 'Stats';
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    List<Steps> steps = provider.steps;
    List<Calories> calories = provider.calories; // Aggiunto recupero dei dati delle calorie

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
                height: 200, // Set the desired height for the plot
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
                height: 200, // Set the desired height for the plot
                child: CaloriesPlot(caloriesData: calories),
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
