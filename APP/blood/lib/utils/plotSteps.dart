import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:blood/models/steps.dart';

class StepDataPlot extends StatelessWidget {
  const StepDataPlot({
    Key? key,
    required this.stepData,
  }) : super(key: key);

  final List<Steps> stepData;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = _aggregateDataByHour(stepData);
    return Chart(
      rebuild: true,
      data: data,
      variables: {
        'date': Variable(
          accessor: (Map map) => map['date'] as String,
          scale: OrdinalScale(tickCount: 5),
        ),
        'steps': Variable(
          accessor: (Map map) => map['steps'] as num,
        ),
      },
      marks: <Mark<Shape>>[
        LineMark(
          position: Varset('date') * Varset('steps'),
          shape: ShapeEncode(value: BasicLineShape(smooth: true)),
          size: SizeEncode(value: 2),
          color: ColorEncode(value: Color.fromARGB(255, 0, 122, 255)),
        ),
        AreaMark(
          gradient: GradientEncode(
            value: LinearGradient(
              begin: const Alignment(0, 0),
              end: const Alignment(0, 1),
              colors: [
                Color.fromARGB(255, 0, 122, 255).withOpacity(0.6),
                const Color(0xFFFFFFFF).withOpacity(0.0),
              ],
            ),
          ),
        ),
      ],
      axes: [
        Defaults.horizontalAxis,
        Defaults.verticalAxis,
      ],
      selections: {'tap': PointSelection(dim: Dim.x)},
    );
  }

  List<Map<String, dynamic>> _aggregateDataByHour(List<Steps> steps) {
    final Map<String, int> aggregatedData = {};

    for (var step in steps) {
      final String hour = DateFormat('yyyy-MM-dd HH').format(step.time);
      if (aggregatedData.containsKey(hour)) {
        aggregatedData[hour] = aggregatedData[hour]! + step.value;
      } else {
        aggregatedData[hour] = step.value;
      }
    }

    return aggregatedData.entries.map((entry) => {
      'date': entry.key,
      'steps': entry.value,
    }).toList();
  }
}
