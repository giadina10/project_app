import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:blood/models/steps.dart';

class StepDataPlot extends StatelessWidget {
  final List<Steps> stepData;

  StepDataPlot({Key? key, required this.stepData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: 'Yesterday steps'),
      primaryXAxis: const DateTimeAxis(majorGridLines: MajorGridLines(width: 0)),
      primaryYAxis: const NumericAxis(
          labelFormat: '{value} steps',
          axisLine: AxisLine(width: 0),
          majorTickLines: MajorTickLines(color: Colors.transparent)),
      series: _getStepDataSeries(),
      tooltipBehavior: TooltipBehavior(enable: true),
    );
  }

  List<LineSeries<Steps, DateTime>> _getStepDataSeries() {
    return <LineSeries<Steps, DateTime>>[
      LineSeries<Steps, DateTime>(
        dataSource: stepData,
        xValueMapper: (data, _) => data.time,
        yValueMapper: (data, _) => data.value,
        name: 'Steps',
        // Remove the MarkerSettings to avoid showing markers
        // markerSettings: const MarkerSettings(isVisible: true)
      ),
    ];
  }
}