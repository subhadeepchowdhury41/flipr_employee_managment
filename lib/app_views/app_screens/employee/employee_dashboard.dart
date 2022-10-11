import 'package:flipr_employee_managment/app_models/task_model.dart';
import 'package:flipr_employee_managment/app_providers/common/auth_provider.dart';
import 'package:flipr_employee_managment/app_providers/task_provider.dart';
import 'package:flipr_employee_managment/app_services/database/employee_services.dart';
import 'package:flipr_employee_managment/app_views/app_screens/employee/employee_add_task_page.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/date_picker.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/pie_chart.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/stacked_bar_chart.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/task_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({Key? key}) : super(key: key);

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard>
    with AutomaticKeepAliveClientMixin {
  late AuthProvider _authProvider;

  late DateTime _date;

  @override
  void initState() {
    DateTime currDate = DateTime.now();
    _date = DateTime.now();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _authProvider = Provider.of<AuthProvider>(context);
    super.didChangeDependencies();
  }

  Future<List<Task>> _getTasks() async {
    List<Task> tasks = await EmployeeServices.getTasks(_authProvider.userId);

    return tasks.where((element) {
      return element.date == '${_date.day}/${_date.month}/${_date.year}';
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Current Day Task Pie-Chart',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            PieChartEmployee(
              date: '${_date.day}/${_date.month}/${_date.year}',
              uid: _authProvider.userId,
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Previous Day Task Pie-Chart',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            PieChartEmployee(
              date: '${_date.day - 1}/${_date.month}/${_date.year}',
              uid: _authProvider.userId,
            ),
            const SizedBox(height: 25),
            StackedBarChart(
              date: '${_date.day}/${_date.month}/${_date.year}',
              uid: _authProvider.userId,
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) {
              return EmployeeAddTaskPage(
                id: _authProvider.userId,
                onTaskAdd: () {
                  setState(() {});
                },
              );
            }),
          ).then((returnedDate) {
            // setState(() {
            //   _date = returnedDate;
            // });
          });
        },
        elevation: 10,
        child: const Center(
          child: Icon(Icons.add_task),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
