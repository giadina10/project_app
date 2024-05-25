import 'package:intl/intl.dart';

class Calories {
  final DateTime time;
  final double value;

  Calories({required this.time, required this.value});

  Calories.fromJson(String date, Map<String, dynamic> json)
      : time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
        value = json.containsKey("value")
            ? double.parse(json["value"].toString())
            : throw ArgumentError("Value cannot be null in Calories"); // Solleva un'eccezione se il valore è null

  @override
  String toString() {
    return 'Calories(time: $time, value: $value)';
  }
}