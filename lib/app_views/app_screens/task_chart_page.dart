import 'package:fl_chart/fl_chart.dart' hide PieChart;
import 'package:flipr_employee_managment/app_views/app_widgets/pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_widgets/stacked_bar_chart.dart';

class TasksChartPage extends StatefulWidget {
  const TasksChartPage({Key? key}) : super(key: key);

  @override
  State<TasksChartPage> createState() => _TasksChartPageState();
}

class _TasksChartPageState extends State<TasksChartPage> {
  final Color leftBarColor = const Color(0xff53fdd7);
  final Color rightBarColor = const Color(0xffff5182);
  final double width = 7;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: Column(
            children: [
              PieChartEmployee(
                uid: 'satendrapal',
                date: '11/09/2022',
              ),
              const SizedBox(height: 30),
              Expanded(
                child: StackedBarChart(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
