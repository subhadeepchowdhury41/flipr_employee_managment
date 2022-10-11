import 'package:flipr_employee_managment/app_models/task_model.dart';
import 'package:flipr_employee_managment/app_providers/common/auth_provider.dart';
import 'package:flipr_employee_managment/app_providers/task_provider.dart';
import 'package:flipr_employee_managment/app_services/database/employee_services.dart';
import 'package:flipr_employee_managment/app_views/app_screens/employee/employee_add_task_page.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/date_picker.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/pie_chart.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/task_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeTaskPage extends StatefulWidget {
  const EmployeeTaskPage({Key? key}) : super(key: key);

  @override
  State<EmployeeTaskPage> createState() => _EmployeeTaskPageState();
}

class _EmployeeTaskPageState extends State<EmployeeTaskPage> {
  late AuthProvider _authProvider;

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
    _authProvider = Provider.of<AuthProvider>(context);
    super.didChangeDependencies();
  }

  void _changeDate(String date) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        // color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: FutureBuilder(
          future: EmployeeServices.getTasks(_authProvider.userId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else {
              if (snapshot.hasData) {
                // List<Task>? tasks = snapshot.data;
                return Column(
                  children: [
                    DatePicker(
                      validate: (DateTime? date) {
                        // if (date == null) {
                        //   return 'Please select a date';
                        // }
                        // if (date != null) {
                        //   String currDate =
                        //       '${date.day}/${date.month}/${date.year}';
                        //   _date = currDate;
                        // }

                        return null;
                      },
                      onChanged: (date) async {
                        // debugPrint('calling async function onchanged\n');
                        _date = date;
                        // await snapshot.data.filterTaskListFromDate(_date!);
                        // debugPrint('calling setState function \n');

                        setState(() {
                          _date;
                        });
                      },
                    ),
                    const SizedBox(height: 25),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            if (_date != null)
                              PieChartEmployee(date: _date!, uid: ''),
                            const SizedBox(height: 25),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                return TaskCard(
                                  task: snapshot.data![index],
                                  navigate: () {

                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) {
              return EmployeeAddTaskPage(id: _authProvider.userId,);
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
