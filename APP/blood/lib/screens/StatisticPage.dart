import 'package:blood/models/steps.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blood/provider/HomeProvider.dart';
import 'package:blood/utils/plot.dart'; // Adjust the import according to your folder structure

class Stats extends StatelessWidget {
  const Stats(this.provider,{Key? key}) : super(key: key);
  static const routename = 'Stats';
  final HomeProvider provider;

  @override
  Widget build(BuildContext context) {
    List<Steps> steps = provider.steps;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body:
          // Assuming 'steps' is a List<Steps> available in HomeProvider
        

           SingleChildScrollView(
            child: Column(
              children: [
                // Container for the plot
                Container(
                  padding: const EdgeInsets.all(16.0),
                  margin: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SizedBox(
                    height: 300, // Set the desired height for the plot
                    child: StepDataPlot(stepData: steps),
                  ),
                ),
                // Add any other content below the plot
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Additional content goes here.',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // Add more widgets or content as needed
              ],
            ),
          )
    );
        }
      
    
  }

