import 'package:intl/intl.dart';

class Steps{
  final DateTime time;
  final int value;

  Steps({required this.time, required this.value});

  Steps.fromJson(String date, Map<String, dynamic> json) :
      time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
      value = int.parse(json["value"]);

  @override
  String toString() {
    return 'Steps(time: $time, value: $value)';
  }//toString

  static List<DateTime> getTimeList(List<Steps> stepsList) {
    return stepsList.map((steps) => steps.time).toList();
   }

  // Metodo per dividere i valori delle Steps in una lista di int
  static List<int> getValueList(List<Steps> stepsList) {
    return stepsList.map((steps) => steps.value).toList();
  }
}//Steps