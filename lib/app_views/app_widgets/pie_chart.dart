import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

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
  Map<String, double> _dataMap = {
    "Break": 8,
    "Meeting": 3,
    "Work": 12,
  };

  Future<bool> _getTheEmployeeTaskDate() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('Pie chart has rebuilt\n');
    return FutureBuilder(
      future: _getTheEmployeeTaskDate(),
      builder: (context, AsyncSnapshot<bool> snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snap.hasData) {
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
        } else {
          return const Center(
            child: Text('Something went wrong'),
          );
        }
      },
    );
  }
}
