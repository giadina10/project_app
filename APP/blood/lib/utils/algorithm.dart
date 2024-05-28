import 'package:blood/models/calories.dart';
import 'package:blood/models/heartrate.dart';
import 'package:blood/models/steps.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Algorithm {
  final SharedPreferences sp; // Dichiarazione della variabile di istanza _sp

  Algorithm(this.sp);
     // Inizializza le shared preferences
  
  

  List<DateTime> heartRateTimes = [];
  List<int> heartRateValues = [];
  List<DateTime> caloriesTimes = [];
  List<double> caloriesValues = [];
  List<DateTime> stepsTimes = [];
  List<int> stepsValues = [];
  String age = '';



  // Definisci la funzione per calcolare la media
  double calculateMean(List<int> values) {
    if (values.isEmpty) return 0.0;
    return values.reduce((a, b) => a + b) / values.length;
  }

  double sum(List<double> numbers) {
    double total = 0;
    for (var number in numbers) {
      total += number;
    }
    return total;
  }

  int sumt(List<int> numbers) {
    int total = 0;
    for (var num in numbers) {
      total += num;
    }
    return total;
  }

  // Implementa il decision tree
  String decisionTree(List<HeartRate> heartrates, List<Calories> calories, List<Steps> steps) {
   // Chiamata al metodo getPreferences per inizializzare _sp

    age = sp.getString('age')!; // Ottenere l'età dalle SharedPreferences
    print('AGEEEEEE');
    print(age);

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


    // Calcola la media dei battiti cardiaci
    double heartRateMean = calculateMean(heartRateValues);

    // Calcola la somma delle calorie
    //double caloriesSum = sum(caloriesValues);

    // Calcola la somma dei passi
    //int stepsSum = sumt(stepsValues);

    print(age);

    // Esegui le condizioni del decision tree
    if (heartRateMean >= 7 ) {
      return "si"; // Tutte le condizioni sono soddisfatte
    } else {
      return "no"; // Almeno una delle condizioni non è soddisfatta
    }
  }
}