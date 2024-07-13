
import 'package:intl/intl.dart';

class HeartRate {
  final DateTime time;
  final int value;
  final int confidence; 

  HeartRate({
    required this.time,
    required this.value,
    this.confidence = 0, 
  });

  HeartRate.fromJson(String date, Map<String, dynamic> json)
      : time = DateFormat('HH:mm:ss').parse('$date ${json["time"]}'), 
        value = int.parse(json["value"]),
        confidence = int.parse(json["value"]); 

  @override
  String toString() {
    return 'HeartRate(time: $time, value: $value, confidence: $confidence)';
  }
   
}