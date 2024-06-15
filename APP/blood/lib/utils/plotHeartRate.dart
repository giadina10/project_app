import 'package:flutter/material.dart';
import 'package:graphic/graphic.dart';
import 'package:intl/intl.dart';
import 'package:blood/models/heartrate.dart';

class HeartRatePlot extends StatelessWidget {
  const HeartRatePlot({
    Key? key,
    required this.heartRateData,
  }) : super(key: key);

  final List<HeartRate> heartRateData;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> data = heartRateData.map((HeartRate hr) => {
      'time': hr.time,
      'value': hr.value,
    }).toList();

    // Filter data to reduce the number of points for better readability
    data = _filterData(data);

    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.greenAccent, width: 3),
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        height: 200, // Set the desired height for the plot
        child: Chart(
          rebuild: true,
          data: data,
          variables: {
            'time': Variable(
              accessor: (Map map) => map['time'] as DateTime,
              scale: TimeScale(
                formatter: (time) => DateFormat('HH:mm').format(time),
                tickCount: 5, // Adjust the number of ticks on the X axis
              ),
            ),
            'value': Variable(
              accessor: (Map map) => map['value'] as num,
            ),
          },
          marks: <Mark<Shape>>[
            LineMark(
              position: Varset('time') * Varset('value'),
              shape: ShapeEncode(value: BasicLineShape(smooth: true)),
              size: SizeEncode(value: 2),
              color: ColorEncode(value: Color.fromARGB(255, 37, 76, 222)),
            ),
            AreaMark(
              gradient: GradientEncode(
                value: LinearGradient(
                  begin: const Alignment(0, 0),
                  end: const Alignment(0, 1),
                  colors: [
                    Color.fromARGB(255, 37, 76, 222).withOpacity(0.6),
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
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _filterData(List<Map<String, dynamic>> data) {
    const int sampleSize = 100; // Adjust the sample size as needed
    if (data.length <= sampleSize) {
      return data;
    }
    int step = data.length ~/ sampleSize;
    return List.generate(sampleSize, (index) => data[index * step]);
  }
}
