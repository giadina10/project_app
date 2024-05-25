import 'package:intl/intl.dart';

class Steps {
  final DateTime time;
  final int value;

  Steps({required this.time, required this.value});

  Steps.fromJson(String date, Map<String, dynamic> json)
      : time = DateFormat('yyyy-MM-dd HH:mm:ss').parse('$date ${json["time"]}'),
        value = json.containsKey("value")
            ? int.parse(json["value"].toString())
            : throw ArgumentError("Value cannot be null in Steps"); // Solleva un'eccezione se il valore è null

  @override
  String toString() {
    return 'Steps(time: $time, value: $value)';
  }
}