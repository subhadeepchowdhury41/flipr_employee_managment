import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import '../../app_models/task_model.dart';
import '../../app_services/database/employee_services.dart';

class StackedBarChart extends StatefulWidget {
  final String uid;
  final String date;
  const StackedBarChart({
    Key? key,
    required this.date,
    required this.uid,
  }) : super(key: key);

  @override
  State<StackedBarChart> createState() => _StackedBarChartState();
}

class _StackedBarChartState extends State<StackedBarChart> {
  @override
  void initState() {
    super.initState();
  }

  List<TaskData> _getTaskData(Map<String, double> taskData) {
    List<TaskData> data = [
      TaskData(
          category: 'Breaks',
          duration: num.parse(taskData['Break'].toString())),
      TaskData(
          category: 'Meeting',
          duration: num.parse(taskData['Meeting'].toString())),
      TaskData(
          category: 'Work', duration: num.parse(taskData['Work'].toString())),
    ];
    return data;
  }

  Future<List<TaskData>> _getTheEmployeeTaskDate() async {
    List<Task> tasksList = await EmployeeServices.getTasks(widget.uid);

    List<Task> tasks = tasksList.where((element) {
      return element.date == widget.date;
    }).toList();

    tasks.sort((task1, task2) {
      DateTime tas1 = DateFormat("dd/MM/yyyy").parse(task1.date);
      DateTime tas2 = DateFormat("dd/MM/yyyy").parse(task2.date);

      if (tas1.day < tas2.day) {
        return tas1.day - tas2.day;
      }
      if (tas1.day == tas2.day) {
        return tas1.month - tas2.month;
      } else {
        return tas1.year - tas2.year;
      }
    });
    Map<String, double> dataMap = {
      "Break": 0,
      "Meeting": 0,
      "Work": 0,
    };

    for (Task task in tasks) {
      debugPrint('task --> ${task.toJson(task)}\n');
      if (task.taskType == 'Break') {
        debugPrint('break --> ${dataMap['Break']!.toString()}\n');
        String duration =
            task.taskDuration.substring(0, task.taskDuration.length - 4);
        debugPrint('duration --> $duration:\n');
        double data = double.parse(duration);
        dataMap['Break'] = data + dataMap['Break']!;
      } else if (task.taskType == 'Meeting') {
        String duration =
            task.taskDuration.substring(0, task.taskDuration.length - 4);
        double data = double.parse(duration);
        dataMap['Meeting'] = data + dataMap['Meeting']!;
      } else if (task.taskType == 'Work') {
        String duration =
            task.taskDuration.substring(0, task.taskDuration.length - 4);
        double data = double.parse(duration);
        dataMap['Work'] = data + dataMap['Work']!;
      }
    }

    List<TaskData> taskDataList = _getTaskData(dataMap) ?? [];

    return taskDataList;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: _getTheEmployeeTaskDate(),
        builder: (context, AsyncSnapshot<List<TaskData>> dataMap) {
          if (dataMap.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (dataMap.hasData) {
            return Column(
              children: [
                SfCartesianChart(
                  title: ChartTitle(
                      text: 'Weekly Task Details of Employee\n (in hours.)'),
                  legend: Legend(isVisible: true),
                  series: <ChartSeries>[
                    StackedColumnSeries<TaskData, String>(
                      dataSource: dataMap.data!,
                      xValueMapper: (TaskData exp, _) => exp.category,
                      yValueMapper: (TaskData exp, _) => exp.duration,
                      name: 'Breaks',
                    ),
                  ],
                  primaryXAxis: CategoryAxis(),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
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
