import 'package:fl_chart/fl_chart.dart' hide PieChart;
import 'package:flipr_employee_managment/app_views/app_widgets/employee_card.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/pie_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_models/user_model.dart';
import '../../app_widgets/date_picker.dart';
import '../../app_widgets/stacked_bar_chart.dart';

class EmployeeChartPage extends StatefulWidget {
  final User employee;
  const EmployeeChartPage({
    Key? key,
    required this.employee,
  }) : super(key: key);

  @override
  State<EmployeeChartPage> createState() => _EmployeeChartPageState();
}

class _EmployeeChartPageState extends State<EmployeeChartPage> {
  late String _date;

  @override
  void initState() {
    /// initializing the date with today
    DateTime curr = DateTime.now();
    _date = '${curr.day}/${curr.month}/${curr.year}';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                EmployeeCard(
                  navigate: () {},
                  employee: widget.employee,
                ),
                const SizedBox(height: 25),
                DatePicker(
                  validate: (DateTime? date) {
                    // if (date == null) {
                    //   return 'Please select a date';
                    // }
                    if (date != null) {
                      String currDate =
                          '${date.day}/${date.month}/${date.year}';
                      _date = currDate;
                    }

                    return null;
                  },
                  onChanged: (date) async {},
                ),
                const SizedBox(height: 15),
                Column(
                  children: [
                    PieChartEmployee(
                      uid: 'satendrapal',
                      date: '11/09/2022',
                    ),
                    const SizedBox(height: 30),
                    StackedBarChart(
                      uid: 'satendrapal',
                      date: '11/09/2022',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
