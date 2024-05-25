import 'package:intl/intl.dart';

class HeartRate {
  final DateTime time;
  final int value;
  final int confidence; // Aggiunto campo per confidence

  HeartRate({
    required this.time,
    required this.value,
    required this.confidence,
  });

  // Metodo per il parsing da JSON
  HeartRate.fromJson(String date, Map<String, dynamic>? json)
      : time = json != null && json.containsKey("time")
            ? DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}')
            : DateTime.now(), // Usa la data corrente come fallback se la data è null
        value = json != null && json.containsKey("value")
            ? int.parse(json["value"].toString())
            : throw ArgumentError("Value cannot be null in HeartRate"), // Solleva un'eccezione se il valore è null
        confidence = json != null && json.containsKey("confidence")
            ? int.parse(json["confidence"].toString())
            : throw ArgumentError("Confidence cannot be null in HeartRate"); // Solleva un'eccezione se la confidence è null

  @override
  String toString() {
    return 'HeartRate(time: $time, value: $value, confidence: $confidence)';
  }
}