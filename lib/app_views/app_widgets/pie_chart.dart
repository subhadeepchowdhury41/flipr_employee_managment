import 'package:flipr_employee_managment/app_providers/admin/employee_provider.dart';
import 'package:flipr_employee_managment/app_services/database/employee_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../app_models/task_model.dart';

class PieChartEmployee extends StatefulWidget {
  final String uid;
  final String date;
  const PieChartEmployee({
    Key? key,
    required this.date,
    required this.uid,
  }) : super(key: key);

  @override
  State<PieChartEmployee> createState() => _PieChartEmployeeState();
}

class _PieChartEmployeeState extends State<PieChartEmployee> {
  late EmployeeProvider _employeeProvider;

  Future<Map<String, double>> _getTheEmployeeTaskDate() async {
    List<Task> tasksList = await EmployeeServices.getTasks(widget.uid);

    List<Task> tasks = tasksList.where((element) {
      return element.date == widget.date;
    }).toList();

    Map<String, double> dataMap = {
      "Break": 0,
      "Meeting": 0,
      "Work": 0,
    };

    for (Task task in tasks) {
      debugPrint('task --> ${task.toJson(task)}\n');
      if (task.taskType == 'Break') {
        // debugPrint('break --> ${dataMap['Break']!.toString()}\n');
        String duration =
            task.taskDuration.substring(0, task.taskDuration.length - 4);
        // debugPrint('duration --> $duration:\n');
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

    return dataMap;
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _employeeProvider = Provider.of<EmployeeProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Pie chart has rebuilt\n');
    return FutureBuilder(
      future: _getTheEmployeeTaskDate(),
      builder: (context, AsyncSnapshot<Map<String, double>> dataMap) {
        if (dataMap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (dataMap.hasData) {
          return Column(
            children: [
              PieChart(
                dataMap: dataMap.data!,
                colorList: const [
                  Colors.redAccent,
                  Colors.orangeAccent,
                  Colors.green
                ],
              ),
            ],
          );
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
