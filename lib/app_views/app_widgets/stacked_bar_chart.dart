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
            yValueMapper: (TaskData exp, _) => exp.breaks,
            name: 'Breaks',
          ),
          StackedColumnSeries<TaskData, String>(
            dataSource: _chartData,
            xValueMapper: (TaskData exp, _) => exp.category,
            yValueMapper: (TaskData exp, _) => exp.work,
            name: 'Work',
          ),
          StackedColumnSeries<TaskData, String>(
            dataSource: _chartData,
            xValueMapper: (TaskData exp, _) => exp.category,
            yValueMapper: (TaskData exp, _) => exp.meeting,
            name: 'Meeting',
          ),
        ],
        primaryXAxis: CategoryAxis(),
      ),
    );
  }

  List<TaskData> _getTaskData() {
    List<TaskData> data = [
      TaskData(category: 'Mon', breaks: 1, meeting: 5, work: 4),
      TaskData(category: 'Tue', breaks: 2, meeting: 5, work: 2),
      TaskData(category: 'Wed', breaks: 2, meeting: 5, work: 2),
      TaskData(category: 'Thur', breaks: 2, meeting: 5, work: 2),
      TaskData(category: 'Fri', breaks: 2, meeting: 5, work: 2),
    ];
    return data;
  }
}

class TaskData {
  final String category;
  final num breaks, meeting, work;

  TaskData({
    required this.category,
    required this.breaks,
    required this.meeting,
    required this.work,
  });
}
