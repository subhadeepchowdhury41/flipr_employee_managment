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

class EmployeeTaskPage extends StatefulWidget {
  const EmployeeTaskPage({Key? key}) : super(key: key);

  @override
  State<EmployeeTaskPage> createState() => _EmployeeTaskPageState();
}

class _EmployeeTaskPageState extends State<EmployeeTaskPage>
    with AutomaticKeepAliveClientMixin {
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

  Future<List<Task>> _getTasks() async {
    List<Task> tasks = await EmployeeServices.getTasks(_authProvider.userId);

    return tasks.where((element) {
      return element.date == _date;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
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
                  setState(() {
                    _date = date;
                  });
                },
              ),
              const SizedBox(height: 25),
              FutureBuilder(
                future: _getTasks(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    if (snapshot.hasData) {
                      // List<Task>? tasks = snapshot.data;
                      return Column(
                        children: [
                          const SizedBox(height: 25),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                const Text(
                                  'Tasks List',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    return TaskCard(
                                      task: snapshot.data![index],
                                      employeeId: _authProvider.userId,
                                      onDelete: () {
                                        setState(() {});
                                      },
                                    );
                                  },
                                ),
                              ],
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
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add task',
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
