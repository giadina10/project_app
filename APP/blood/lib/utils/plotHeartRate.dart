import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:blood/models/heartRate.dart';

class HeartRatePlot extends StatelessWidget {
  const HeartRatePlot({
    Key? key,
    required this.heartRateData,
  }) : super(key: key);

  final List<HeartRate> heartRateData;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = heartRateData.map((heartRate) => {
      'time': heartRate.time.toIso8601String(),
      'heartRate': heartRate.value,
    }).toList();

    return Chart(
      rebuild: true,
      data: data,
      variables: {
        'time': Variable(
          accessor: (Map map) => DateTime.parse(map['time']),
          scale: TimeScale(tickCount: 5),
        ),
        'heartRate': Variable(
          accessor: (Map map) => map['heartRate'] as num,
        ),
      },
      marks: <Mark<Shape>>[
        LineMark(
          position: Varset('time') * Varset('heartRate'),
          shape: ShapeEncode(value: BasicLineShape(smooth: true)),
          size: SizeEncode(value: 2),
          color: ColorEncode(value: Colors.greenAccent),
        ),
        PointMark(
          size: SizeEncode(value: 5),
          color: ColorEncode(value: Colors.greenAccent),
        ),
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
      selections: {'tap': PointSelection(dim: Dim.x)},
    );
  }
}
