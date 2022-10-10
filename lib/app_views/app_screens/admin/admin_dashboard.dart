import 'package:flipr_employee_managment/app_providers/task_provider.dart';
import 'package:flipr_employee_managment/app_views/app_screens/employee/employee_add_task_page.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/date_picker.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/pie_chart.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/task_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_providers/employee_provider.dart';
import '../../app_widgets/employee_card.dart';
import 'add_employee_page.dart';
import 'employee_charts_page.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  late EmployeeProvider _employeeProvider;

  String? _date;

  Future<int> _getTasksList() async {
    return 6;
  }

  @override
  void initState() {
    DateTime currDate = DateTime.now();
    _date = '${currDate.day}/${currDate.month}/${currDate.year}';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _employeeProvider = Provider.of<EmployeeProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Container(
        // color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: FutureBuilder(
          future: _employeeProvider.setEmployeeList(),
          builder: (context, AsyncSnapshot<void> snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snap.hasError) {
              return const Text('Something went wrong');
            } else {
              return Consumer<EmployeeProvider>(
                builder: (_, employeeProvider, child) {
                  return ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: employeeProvider.employeeList.length,
                    itemBuilder: (context, index) {
                      return EmployeeCard(
                        employee: employeeProvider.employeeList[index],
                        navigate: () {
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (context) => EmployeeChartPage(
                                employee: employeeProvider.employeeList[index],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) {
              return const AddEmployeePage();
            }),
          );
        },
        elevation: 10,
        child: const Center(
          child: Icon(Icons.add_task),
        ),
      ),
    );
  }
}
