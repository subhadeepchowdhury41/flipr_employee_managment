import 'package:flipr_employee_managment/app_views/app_widgets/app_input_field.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/date_picker.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/dropdown_input.dart';
import 'package:flutter/material.dart';

import '../../app_widgets/time_duration_input.dart';

class EmployeeAddTaskPage extends StatefulWidget {
  const EmployeeAddTaskPage({Key? key}) : super(key: key);

  @override
  State<EmployeeAddTaskPage> createState() => _EmployeeAddTaskPageState();
}

class _EmployeeAddTaskPageState extends State<EmployeeAddTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _date, _description, _type, _duration;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                DatePicker(
                  validate: (DateTime? date) {
                    if (date == null) {
                      return 'Please select a date';
                    }

                    String currDate = '${date.day}/${date.month}/${date.year}';
                    _date = currDate;
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                AppTextInputWidget(
                  validate: (String? val) {
                    if (val == null || val.isEmpty) {
                      return 'Please add description';
                    }
                    return null;
                  },
                  hintText: 'Description',
                ),
                const SizedBox(height: 25),
                DropdownMenu(
                  taskTypes: const ['Break', 'Meeting', 'Work'],
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
                const SizedBox(height: 25),
                TimeDurationInputWidget(
                  validate: (String? val, String timeType) {
                    if (val == null ||
                        val.isEmpty ||
                        double.tryParse(val) == null) {
                      return 'Please give task duration';
                    }
                    _duration = '$val $timeType';

                    return null;
                  },
                  hintText: 'Task Duration',
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
