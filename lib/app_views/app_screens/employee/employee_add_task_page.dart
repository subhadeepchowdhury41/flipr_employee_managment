import 'package:flipr_employee_managment/app_views/app_widgets/app_input_field.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/dropdown_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmployeeAddTaskPage extends StatefulWidget {
  const EmployeeAddTaskPage({Key? key}) : super(key: key);

  @override
  State<EmployeeAddTaskPage> createState() => _EmployeeAddTaskPageState();
}

class _EmployeeAddTaskPageState extends State<EmployeeAddTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _taskDescriptionTextEditionController =
      TextEditingController();
  final TextEditingController _taskTypeTextEditionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        alignment: Alignment.center,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AppTextInputWidget(
                validate: (String? val) {
                  if (val == null || val.isEmpty) {
                    return 'Please add description';
                  }
                  return null;
                },
                textEditingController: _taskDescriptionTextEditionController,
                hintText: 'Description',
              ),
              DropdownMenu(
                taskTypes: const ['Break, Meeting, Work'],
                textEditingController: _taskTypeTextEditionController,
                hintText: 'Task Type',
                validate: (taskType) {
                  if (taskType == null ||
                      taskType.isEmpty ||
                      taskType == 'Task Type') {
                    return 'Please choose a task type';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
