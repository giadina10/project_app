
import 'package:decision_tree/decision_tree.dart';


// Definisci la funzione per calcolare la media
double calculateMean(List<int> values) {
  if (values.isEmpty) return 0.0;
  return values.reduce((a, b) => a + b) / values.length;
}

// Implementa il decision tree
bool decisionTree(List<int> heartRates, List<double> calories, List<int> steps) {
  // Calcola la media dei battiti cardiaci
  double heartRateMean = calculateMean(heartRates);

  // Calcola la somma delle calorie
  double caloriesSum = calories.reduce((a, b) => a + b);

  // Calcola la somma dei passi
  int stepsSum = steps.reduce((a, b) => a + b);

  // Esegui le condizioni del decision tree
  if (heartRateMean >= 70 && heartRateMean <= 120 && caloriesSum == 50 && stepsSum == 10000) {
    return true; // Tutte le condizioni sono soddisfatte
  } else {
    return false; // Almeno una delle condizioni non è soddisfatta
  }
}

void main() {
  // Dati di esempio
  List<int> heartRates = [69, 70, 71, 70, 70, 70, 71, 70, 70, 71, 72, 71]; // Esempio di battiti cardiaci
  List<double> calories = [1.28, 1.28, 1.28, 1.28, 1.28, 1.28, 1.28, 1.28]; // Esempio di calorie
  List<int> steps = [0, 0, 0, 0, 16, 28, 0, 0]; // Esempio di passi

  // Esegui il decision tree sui dati di esempio
  bool result = decisionTree(heartRates, calories, steps);

  // Stampa il risultato
  print('Il risultato del decision tree è: $result');
}