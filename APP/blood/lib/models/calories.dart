import 'package:intl/intl.dart';

class Calories {
  final DateTime time;
  final double value; // Changed type to double

  Calories({required this.time, required this.value});

  Calories.fromJson(String date, Map<String, dynamic> json)
      : time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
        value = double.parse(json["value"]); // Use double.parse for decimals

  @override
  String toString() {
    return 'Calories(time: $time, value: $value)';
  }
}