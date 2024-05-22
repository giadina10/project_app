
import 'package:intl/intl.dart';

class HeartRate {
  final DateTime time;
  final int value;
  final int confidence; // Added field for confidence

  HeartRate({
    required this.time,
    required this.value,
    this.confidence = 0, // Set default confidence to 0
  });

  HeartRate.fromJson(String date, Map<String, dynamic> json)
      : time = DateFormat('HH:mm:ss').parse('$date ${json["time"]}'), // Parse time in hh:mm:ss format
        value = int.parse(json["value"]),
        confidence = int.parse(json["value"]); // Parse confidence with default 0

  @override
  String toString() {
    return 'HeartRate(time: $time, value: $value, confidence: $confidence)';
  }
}