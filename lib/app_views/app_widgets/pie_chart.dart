import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
class PieChartEmployee extends StatefulWidget {
  const PieChartEmployee({Key? key}) : super(key: key);

  @override
  State<PieChartEmployee> createState() => _PieChartEmployeeState();
}

class _PieChartEmployeeState extends State<PieChartEmployee> {
  Map<String, double> _dataMap = {
    "Break": 5,
    "Meeting": 3,
    "Work": 2,
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PieChart(
          dataMap: _dataMap,
          colorList: const [
            Colors.redAccent,
            Colors.orangeAccent,
            Colors.green
          ],
        ),
      ],
    );
  }
}
