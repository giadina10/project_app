import 'package:blood/models/heartrate.dart';
import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';


class CustomPlot extends StatelessWidget {
  const CustomPlot({
    Key? key,
    required this.heartrates,
  }) : super(key: key);

  final List<HeartRate> heartrates;

  @override
  Widget build(BuildContext context) {
    // Estrarre i valori e i timestamp dai dati di input
    List<DateTime> timestamps = heartrates.map((hr) => hr.time).toList();
    List<int> values = heartrates.map((hr) => hr.value).toList();

    List<Map<String, dynamic>> data = _parseData(values, timestamps);

    return Chart(
      rebuild: true,
      data: data,
      variables: {
        'date': Variable(
          accessor: (Map map) => map['date'] as String,
          scale: OrdinalScale(tickCount: 5),
        ),
        'points': Variable(
          accessor: (Map map) => map['points'] as num,
        ),
      },
      marks: <Mark<Shape>>[
        LineMark(
          position: Varset('date') * Varset('points'),
          shape: ShapeEncode(value: BasicLineShape(smooth: true)),
          size: SizeEncode(value: 2),
          color: ColorEncode(value: Colors.blue),
        ),
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
      selections: {'tap': PointSelection(dim: Dim.x)},
    );
  }

  List<Map<String, dynamic>> _parseData(List<int> values, List<DateTime> timestamps) {
    return List.generate(values.length, (index) {
      return {
        'date': DateFormat('yyyy-MM-dd').format(timestamps[index]),
        'points': values[index],
      };
    });
  }
}
