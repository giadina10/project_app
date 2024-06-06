import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:blood/models/calories.dart';

class CaloriesPlot extends StatelessWidget {
  const CaloriesPlot({
    Key? key,
    required this.caloriesData,
  }) : super(key: key);

  final List<Calories> caloriesData;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = _aggregateCaloriesByHour(caloriesData);
    return Chart(
      rebuild: true,
      data: data,
      variables: {
        'date': Variable(
          accessor: (Map map) => map['date'] as String,
          scale: OrdinalScale(tickCount: 5),
        ),
        'calories': Variable(
          accessor: (Map map) => map['calories'] as num,
        ),
      },
      marks: <Mark<Shape>>[
        LineMark(
          position: Varset('date') * Varset('calories'),
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

  List<Map<String, dynamic>> _aggregateCaloriesByHour(List<Calories> calories) {
    final Map<String, double> aggregatedData = {};

    for (var calorie in calories) {
      final String hour = DateFormat('yyyy-MM-dd HH').format(calorie.time);
      if (aggregatedData.containsKey(hour)) {
        aggregatedData[hour] = aggregatedData[hour]! + calorie.value;
      } else {
        aggregatedData[hour] = calorie.value;
      }
      
    }
    print('OK');
    print(aggregatedData);

    return aggregatedData.entries.map((entry) => {
      'date': entry.key,
      'calories': entry.value,
    }).toList();
  }
}
