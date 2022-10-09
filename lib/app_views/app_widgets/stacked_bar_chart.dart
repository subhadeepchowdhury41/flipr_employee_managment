import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class StackedBarChart extends StatefulWidget {
  const StackedBarChart({Key? key}) : super(key: key);

  @override
  State<StackedBarChart> createState() => _StackedBarChartState();
}

class _StackedBarChartState extends State<StackedBarChart> {
  late List<TaskData> _chartData;

  @override
  void initState() {
    // TODO: implement initState
    _chartData = _getTaskData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfCartesianChart(
        title:
            ChartTitle(text: 'Weekly Task Details of Employee\n (in hours.)'),
        legend: Legend(isVisible: true),
        series: <ChartSeries>[
          StackedColumnSeries<TaskData, String>(
            dataSource: _chartData,
            xValueMapper: (TaskData exp, _) => exp.category,
            yValueMapper: (TaskData exp, _) => exp.duration,
            name: 'Breaks',
          ),
        ],
        primaryXAxis: CategoryAxis(),
      ),
    );
  }

  List<TaskData> _getTaskData() {
    List<TaskData> data = [
      TaskData(category: 'Breaks', duration: 5),
      TaskData(category: 'Meeting', duration: 8),
      TaskData(category: 'Work', duration: 30),
    ];
    return data;
  }
}

class TaskData {
  final String category;
  final num duration;

  TaskData({
    required this.category,
    required this.duration,
  });
}
