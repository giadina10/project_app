import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:blood/models/heartRate.dart';
import 'package:intl/intl.dart';

class HeartRatePlot extends StatelessWidget {
  const HeartRatePlot({
    Key? key,
    required this.heartRateData,
  }) : super(key: key);

  final List<HeartRate> heartRateData;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = heartRateData.map((hr) => {
      'time': hr.time,
      'heartRate': hr.value,
    }).toList();

    return Chart(
      rebuild: true,
      data: data,
      variables: {
        'time': Variable(
          accessor: (Map map) => map['time'] as DateTime,
          scale: TimeScale(
            formatter: (time) => DateFormat('HH:mm').format(time),
            tickCount: 5,
          ),
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
          color: ColorEncode(value: Color.fromARGB(255, 0, 122, 255)),
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
