import 'package:flipr_employee_managment/app_services/database/employee_services.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/app_input_field.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/app_rounded_button.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/date_picker.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/dropdown_input.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/time_picker.dart';
import 'package:flutter/material.dart';
import '../../app_widgets/time_duration_input.dart';

class EmployeeAddTaskPage extends StatefulWidget {
  const EmployeeAddTaskPage({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<EmployeeAddTaskPage> createState() => _EmployeeAddTaskPageState();
}

class _EmployeeAddTaskPageState extends State<EmployeeAddTaskPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _taskStartTime, _date, _taskDescription, _taskType, _taskDuration;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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

                      String currDate =
                          '${date.day}/${date.month}/${date.year}';
                      _date = currDate;
                      return null;
                    },
                    onChanged: (value) async {
                      return;
                    },
                  ),
                  const SizedBox(height: 25),

                  /// task description
                  AppTextInputWidget(
                    validate: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'Please add description';
                      }
                      _taskDescription = val;
                      return null;
                    },
                    hintText: 'Description',
                  ),
                  const SizedBox(height: 25),

                  /// task type
                  DropdownMenu(
                    taskTypes: const ['Break', 'Meeting', 'Work'],
                    hintText: 'Task Type',
                    validate: (taskType) {
                      if (taskType == null ||
                          taskType.isEmpty ||
                          taskType == 'Task Type') {
                        return 'Please choose a task type';
                      }
                      _taskType = taskType;
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),

                  TimePicker(validate: (TimeOfDay? timeOfDay) {
                    if (timeOfDay == null) {
                      return 'Please choose task time';
                    }
                    _taskStartTime =
                        '${timeOfDay.hour} : ${timeOfDay.minute}  ${timeOfDay.period == DayPeriod.am ? 'AM' : 'PM'}';
                    return null;
                  }),
                  const SizedBox(height: 25),

                  /// task duration
                  TimeDurationInputWidget(
                    validate: (String? val, String timeType) {
                      if (val == null ||
                          val.isEmpty ||
                          double.tryParse(val) == null) {
                        return 'Please give task duration';
                      }
                      _taskDuration = '$val $timeType';

                      return null;
                    },
                    hintText: 'Task Duration',
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 30),

                  /// add task button
                  AppRoundedButton(
                    onPress: () async => await _validateAndAddTask(),
                    buttonText: 'Add Task',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validateAndAddTask() async {
    if (_formKey.currentState!.validate()) {
      EmployeeServices.addTask({
        'description': _taskDescription,
        'type': _taskType,
        'startTime': _taskStartTime,
        'duration': _taskDuration,
        'date': _date
      }, widget.id);
      Navigator.pop(context);
    }
  }
}
