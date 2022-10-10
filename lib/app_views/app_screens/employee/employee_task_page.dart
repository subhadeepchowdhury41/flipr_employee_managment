import 'package:flipr_employee_managment/app_providers/task_provider.dart';
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
  late TaskProvider _taskProvider;

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
    _taskProvider = Provider.of<TaskProvider>(context);
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
        child: Consumer<TaskProvider>(
          builder: (_, taskProvider, child) {
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
                    await taskProvider.filterTaskListFromDate(_date!);
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
                          itemCount: taskProvider.tasksList.length,
                          itemBuilder: (context, index) {
                            return TaskCard(
                              task: taskProvider.tasksList[index],
                              navigate: () {},
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) {
              return const EmployeeAddTaskPage();
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
