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
  int? bs; // 0 per maschio, 1 per femmina



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
    bs = sp.getInt('bs'); //0 = male, 1 = female

    //svuoto le liste per evitare che ogni volta che faccio tap su uno dei tre giorni mi sommi i passi e calorie
    //a quelli dei tap precedenti (ottenendo valori non reali)
    stepsValues.clear();
    caloriesValues.clear();

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
    print('QUESTO è IL BATTIMO MEDIO');
    print(heartRateMean);

    // Calcola la somma delle calorie totali di 3 giorni
    double caloriesSum = sum(caloriesValues);
     print('QUESTE SONO LE CALORIE');
    print(caloriesSum);

    // Calcola la somma dei passi totali di 3 giorni
    int stepsSum = sumt(stepsValues); //se questa somma è maggiore di 1900x3 = 5700 kcal, vuol dire che ha consumato troppe calorie
    //e dovrebbe prestare attenzione perchè donare fa bruciare 650 kcal quindi è consigliabile una buona colazione prima di donare (no latticini etc)

    print('QUESTI SONO I PASSI');
    print(stepsSum);

    // Esegui le condizioni del decision tree
    if (bs == 1 ) { //se è femmina
    if (int.parse(age) >= 18 && int.parse(age) <= 25) { //età tra 18-25
        if (heartRateMean > 95){
          return "1"; //1 sta per = battito cardiaco troppo alto, non donare
        }
        else { //se battito è minore facciamo il controllo sui passi + calorie
        if (stepsSum > 15000){ //passi compresi nel range giusto (attività fisica minima ossia 5000 passi al giorno)
          if (caloriesSum <5700){
            return "2"; //2 significa che ha battiti cardiaci giusti+ passi giusti + non ha bruciato troppe calorie
            //quindi è PERFETTO PER DONARE
          } 
          else {
            return "3"; //3 significa che ha battiti cardiaci giusti+passi giusti+ MA ha bruciato troppe calorie.
            //fornire un consiglio su mangiare qualcosa a colazione perchè donazione implica perdita di 650 kcal
          }
        }
        else { //se i passi sono inferiori al minimo (15000)
           if (caloriesSum < 5700){
            return "4"; //4 significa che non ha fatto tanta attività fisica (neanche da fermo), però ha i battiti cardiaci giusti
            //quindi forniamo un consiglio su fare più attività fisica.
           }
           else { //se però ha fatto comunque attività fisica (non in termini di passi)
            return "2"; // come il primo caso di 2: significa che ha fatto pochi passi però ha compensato con altra attività fisica + ha i battiti cardiaci giusti. forniamo lo 
            //stesso consiglio
            }

           }
        


        }

        }
        //prossimo range di età
        else if (int.parse(age) >= 26 && int.parse(age) <= 35){
          if (heartRateMean > 90){ //dai 26 ai 35 ci si aspetta un battito non maggiore di 90 bpm in media
          return "1"; //1 sta per = battito cardiaco troppo alto, non donare
        }
        else { //se battito è minore facciamo il controllo sui passi + calorie
        if (stepsSum > 15000){ //passi compresi nel range giusto (attività fisica minima ossia 5000 passi al giorno)
          if (caloriesSum <5700){
            return "2"; //2 significa che ha battiti cardiaci giusti+ passi giusti + non ha bruciato troppe calorie
            //quindi è PERFETTO PER DONARE
          } 
          else {
            return "3"; //3 significa che ha battiti cardiaci giusti+passi giusti+ MA ha bruciato troppe calorie.
            //fornire un consiglio su mangiare qualcosa a colazione perchè donazione implica perdita di 650 kcal
          }
        }
        else { //se i passi sono inferiori al minimo (15000)
           if (caloriesSum < 5700){
            return "4"; //4 significa che non ha fatto tanta attività fisica (neanche da fermo), però ha i battiti cardiaci giusti
            //quindi forniamo un consiglio su fare più attività fisica.
           }
           else { //se però ha fatto comunque attività fisica (non in termini di passi)
            return "2"; // come il primo caso di 2: significa che ha fatto pochi passi però ha compensato con altra attività fisica + ha i battiti cardiaci giusti. forniamo lo 
            //stesso consiglio
            }

           }
        


        }

        }
        else if (int.parse(age) >= 36 && int.parse(age) <= 45){
          if (heartRateMean > 85){ //dai 36 ai 45 ci si aspetta un battito non maggiore di 85 bpm in media
          return "1"; //1 sta per = battito cardiaco troppo alto, non donare
        }
        else { //se battito è minore facciamo il controllo sui passi + calorie
        if (stepsSum > 15000){ //passi compresi nel range giusto (attività fisica minima ossia 5000 passi al giorno)
          if (caloriesSum <5700){
            return "2"; //2 significa che ha battiti cardiaci giusti+ passi giusti + non ha bruciato troppe calorie
            //quindi è PERFETTO PER DONARE
          } 
          else {
            return "3"; //3 significa che ha battiti cardiaci giusti+passi giusti+ MA ha bruciato troppe calorie.
            //fornire un consiglio su mangiare qualcosa a colazione perchè donazione implica perdita di 650 kcal
          }
        }
        else { //se i passi sono inferiori al minimo (15000)
           if (caloriesSum < 5700){
            return "4"; //4 significa che non ha fatto tanta attività fisica (neanche da fermo), però ha i battiti cardiaci giusti
            //quindi forniamo un consiglio su fare più attività fisica.
           }
           else { //se però ha fatto comunque attività fisica (non in termini di passi)
            return "2"; // come il primo caso di 2: significa che ha fatto pochi passi però ha compensato con altra attività fisica + ha i battiti cardiaci giusti. forniamo lo 
            //stesso consiglio
            }

           }
        }
        


        }
        else if (int.parse(age) >= 46 && int.parse(age) <= 55){
          if (heartRateMean > 80){ //dai 46 ai 55 ci si aspetta un battito non maggiore di 80 bpm in media
          return "1"; //1 sta per = battito cardiaco troppo alto, non donare
        }
        else { //se battito è minore facciamo il controllo sui passi + calorie
        if (stepsSum > 15000){ //passi compresi nel range giusto (attività fisica minima ossia 5000 passi al giorno)
          if (caloriesSum <5400){
            return "2"; //2 significa che ha battiti cardiaci giusti+ passi giusti + non ha bruciato troppe calorie
            //quindi è PERFETTO PER DONARE
          } 
          else {
            return "3"; //3 significa che ha battiti cardiaci giusti+passi giusti+ MA ha bruciato troppe calorie.
            //fornire un consiglio su mangiare qualcosa a colazione perchè donazione implica perdita di 650 kcal
          }
        }
        else { //se i passi sono inferiori al minimo (15000)
           if (caloriesSum < 5400){
            return "4"; //4 significa che non ha fatto tanta attività fisica (neanche da fermo), però ha i battiti cardiaci giusti
            //quindi forniamo un consiglio su fare più attività fisica.
           }
           else { //se però ha fatto comunque attività fisica (non in termini di passi)
            return "2"; // come il primo caso di 2: significa che ha fatto pochi passi però ha compensato con altra attività fisica + ha i battiti cardiaci giusti. forniamo lo 
            //stesso consiglio
            }

           }
        }
        }
        else if (int.parse(age) >= 56 && int.parse(age) <= 65){
          if (heartRateMean > 75){ //dai 56 ai 65 ci si aspetta un battito non maggiore di 75 bpm in media
          return "1"; //1 sta per = battito cardiaco troppo alto, non donare
        }
        else { //se battito è minore facciamo il controllo sui passi + calorie
        if (stepsSum > 15000){ //passi compresi nel range giusto (attività fisica minima ossia 5000 passi al giorno)
          if (caloriesSum <5400){
            return "2"; //2 significa che ha battiti cardiaci giusti+ passi giusti + non ha bruciato troppe calorie
            //quindi è PERFETTO PER DONARE
          } 
          else {
            return "3"; //3 significa che ha battiti cardiaci giusti+passi giusti+ MA ha bruciato troppe calorie.
            //fornire un consiglio su mangiare qualcosa a colazione perchè donazione implica perdita di 650 kcal
          }
        }
        else { //se i passi sono inferiori al minimo (15000)
           if (caloriesSum < 5400){
            return "4"; //4 significa che non ha fatto tanta attività fisica (neanche da fermo), però ha i battiti cardiaci giusti
            //quindi forniamo un consiglio su fare più attività fisica.
           }
           else { //se però ha fatto comunque attività fisica (non in termini di passi)
            return "2"; // come il primo caso di 2: significa che ha fatto pochi passi però ha compensato con altra attività fisica + ha i battiti cardiaci giusti. forniamo lo 
            //stesso consiglio
            }

           }
        }
        }



    } 
       

        //BS == 0 
        else  {
          if (int.parse(age) >= 18 && int.parse(age) <= 25) { //età tra 18-25
        if (heartRateMean > 100){
          return "1"; //1 sta per = battito cardiaco troppo alto, non donare
        }
        else { //se battito è minore facciamo il controllo sui passi + calorie
        if (stepsSum > 15000){ //passi compresi nel range giusto (attività fisica minima ossia 5000 passi al giorno)
          if (caloriesSum <7500){
            return "2"; //2 significa che ha battiti cardiaci giusti+ passi giusti + non ha bruciato troppe calorie
            //quindi è PERFETTO PER DONARE
          } 
          else {
            return "3"; //3 significa che ha battiti cardiaci giusti+passi giusti+ MA ha bruciato troppe calorie.
            //fornire un consiglio su mangiare qualcosa a colazione perchè donazione implica perdita di 650 kcal
          }
        }
        else { //se i passi sono inferiori al minimo (15000)
           if (caloriesSum < 7500){
            return "4"; //4 significa che non ha fatto tanta attività fisica (neanche da fermo), però ha i battiti cardiaci giusti
            //quindi forniamo un consiglio su fare più attività fisica.
           }
           else { //se però ha fatto comunque attività fisica (non in termini di passi)
            return "2"; // come il primo caso di 2: significa che ha fatto pochi passi però ha compensato con altra attività fisica + ha i battiti cardiaci giusti. forniamo lo 
            //stesso consiglio
            }

           }
        


        }

        }
        //prossimo range di età
        else if (int.parse(age) >= 26 && int.parse(age) <= 35){
          if (heartRateMean > 95){ //dai 26 ai 35 ci si aspetta un battito non maggiore di 90 bpm in media
          return "1"; //1 sta per = battito cardiaco troppo alto, non donare
        }
        else { //se battito è minore facciamo il controllo sui passi + calorie
        if (stepsSum > 15000){ //passi compresi nel range giusto (attività fisica minima ossia 5000 passi al giorno)
          if (caloriesSum <7200){
            return "2"; //2 significa che ha battiti cardiaci giusti+ passi giusti + non ha bruciato troppe calorie
            //quindi è PERFETTO PER DONARE
          } 
          else {
            return "3"; //3 significa che ha battiti cardiaci giusti+passi giusti+ MA ha bruciato troppe calorie.
            //fornire un consiglio su mangiare qualcosa a colazione perchè donazione implica perdita di 650 kcal
          }
        }
        else { //se i passi sono inferiori al minimo (15000)
           if (caloriesSum < 7200){
            return "4"; //4 significa che non ha fatto tanta attività fisica (neanche da fermo), però ha i battiti cardiaci giusti
            //quindi forniamo un consiglio su fare più attività fisica.
           }
           else { //se però ha fatto comunque attività fisica (non in termini di passi)
            return "2"; // come il primo caso di 2: significa che ha fatto pochi passi però ha compensato con altra attività fisica + ha i battiti cardiaci giusti. forniamo lo 
            //stesso consiglio
            }

           }
        


        }

        }
        else if (int.parse(age) >= 36 && int.parse(age) <= 45){
          if (heartRateMean > 90){ //dai 36 ai 45 ci si aspetta un battito non maggiore di 85 bpm in media
          return "1"; //1 sta per = battito cardiaco troppo alto, non donare
        }
        else { //se battito è minore facciamo il controllo sui passi + calorie
        if (stepsSum > 15000){ //passi compresi nel range giusto (attività fisica minima ossia 5000 passi al giorno)
          if (caloriesSum <7200){
            return "2"; //2 significa che ha battiti cardiaci giusti+ passi giusti + non ha bruciato troppe calorie
            //quindi è PERFETTO PER DONARE
          } 
          else {
            return "3"; //3 significa che ha battiti cardiaci giusti+passi giusti+ MA ha bruciato troppe calorie.
            //fornire un consiglio su mangiare qualcosa a colazione perchè donazione implica perdita di 650 kcal
          }
        }
        else { //se i passi sono inferiori al minimo (15000)
           if (caloriesSum < 7200){
            return "4"; //4 significa che non ha fatto tanta attività fisica (neanche da fermo), però ha i battiti cardiaci giusti
            //quindi forniamo un consiglio su fare più attività fisica.
           }
           else { //se però ha fatto comunque attività fisica (non in termini di passi)
            return "2"; // come il primo caso di 2: significa che ha fatto pochi passi però ha compensato con altra attività fisica + ha i battiti cardiaci giusti. forniamo lo 
            //stesso consiglio
            }

           }
        }
        


        }
        else if (int.parse(age) >= 46 && int.parse(age) <= 55){
          if (heartRateMean > 85){ //dai 46 ai 55 ci si aspetta un battito non maggiore di 80 bpm in media
          return "1"; //1 sta per = battito cardiaco troppo alto, non donare
        }
        else { //se battito è minore facciamo il controllo sui passi + calorie
        if (stepsSum > 15000){ //passi compresi nel range giusto (attività fisica minima ossia 5000 passi al giorno)
          if (caloriesSum <6600){
            return "2"; //2 significa che ha battiti cardiaci giusti+ passi giusti + non ha bruciato troppe calorie
            //quindi è PERFETTO PER DONARE
          } 
          else {
            return "3"; //3 significa che ha battiti cardiaci giusti+passi giusti+ MA ha bruciato troppe calorie.
            //fornire un consiglio su mangiare qualcosa a colazione perchè donazione implica perdita di 650 kcal
          }
        }
        else { //se i passi sono inferiori al minimo (15000)
           if (caloriesSum < 6600){
            return "4"; //4 significa che non ha fatto tanta attività fisica (neanche da fermo), però ha i battiti cardiaci giusti
            //quindi forniamo un consiglio su fare più attività fisica.
           }
           else { //se però ha fatto comunque attività fisica (non in termini di passi)
            return "2"; // come il primo caso di 2: significa che ha fatto pochi passi però ha compensato con altra attività fisica + ha i battiti cardiaci giusti. forniamo lo 
            //stesso consiglio
            }

           }
        }
        }
        else if (int.parse(age) >= 56 && int.parse(age) <= 65){
          if (heartRateMean > 80){ //dai 56 ai 65 ci si aspetta un battito non maggiore di 75 bpm in media
          return "1"; //1 sta per = battito cardiaco troppo alto, non donare
        }
        else { //se battito è minore facciamo il controllo sui passi + calorie
        if (stepsSum > 15000){ //passi compresi nel range giusto (attività fisica minima ossia 5000 passi al giorno)
          if (caloriesSum <6600){
            return "2"; //2 significa che ha battiti cardiaci giusti+ passi giusti + non ha bruciato troppe calorie
            //quindi è PERFETTO PER DONARE
          } 
          else {
            return "3"; //3 significa che ha battiti cardiaci giusti+passi giusti+ MA ha bruciato troppe calorie.
            //fornire un consiglio su mangiare qualcosa a colazione perchè donazione implica perdita di 650 kcal
          }
        }
        else { //se i passi sono inferiori al minimo (15000)
           if (caloriesSum < 6600){
            return "4"; //4 significa che non ha fatto tanta attività fisica (neanche da fermo), però ha i battiti cardiaci giusti
            //quindi forniamo un consiglio su fare più attività fisica.
           }
           else { //se però ha fatto comunque attività fisica (non in termini di passi)
            return "2"; // come il primo caso di 2: significa che ha fatto pochi passi però ha compensato con altra attività fisica + ha i battiti cardiaci giusti. forniamo lo 
            //stesso consiglio
            }

           }
        }
        }

        

        }
        return 'ciao nessuna decisione presa';
        
       }
      
    
}

      

        
      

    
  

