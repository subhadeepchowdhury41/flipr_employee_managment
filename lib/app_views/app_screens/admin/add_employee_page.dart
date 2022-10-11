import 'package:flipr_employee_managment/app_views/app_widgets/app_input_field.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/app_rounded_button.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/date_picker.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/dropdown_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_providers/admin/employee_provider.dart';

class AddEmployeePage extends StatefulWidget {
  const AddEmployeePage({Key? key}) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late EmployeeProvider _employeeProvider;

  String? _username,
      _profession,
      _email,
      _contactNo,
      _department,
      _joiningDate,
      _password;

  @override
  void didChangeDependencies() {
    _employeeProvider = Provider.of<EmployeeProvider>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Employee'),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  /// username
                  AppTextInputWidget(
                    validate: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'Please add username';
                      }
                      _username = val;
                      return null;
                    },
                    hintText: 'username',
                  ),
                  const SizedBox(height: 25),

                  AppTextInputWidget(
                    validate: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'Please add password';
                      }
                      _password = val;
                      return null;
                    },
                    hintText: 'password',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 25),

                  /// user email
                  AppTextInputWidget(
                    validate: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'Please add email';
                      }
                      _email = val;
                      return null;
                    },
                    hintText: 'email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 25),

                  /// contact number
                  AppTextInputWidget(
                    validate: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'Please add contact number';
                      }
                      _contactNo = val;
                      return null;
                    },
                    hintText: 'phone number',
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 25),

                  /// role
                  AppTextInputWidget(
                    validate: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'Please add role';
                      }
                      _profession = val;
                      return null;
                    },
                    hintText: 'role',
                  ),
                  const SizedBox(height: 25),

                  /// joining date
                  DatePicker(
                    validate: (DateTime? date) {
                      if (date == null) {
                        return 'Please select a joining date';
                      }

                      String currDate =
                          '${date.day}/${date.month}/${date.year}';
                      _joiningDate = currDate;
                      return null;
                    },
                    onChanged: (value) async {
                      return;
                    },
                  ),
                  const SizedBox(height: 25),

                  /// department
                  DropdownMenu(
                    taskTypes: const [
                      'IT',
                      'HR',
                      'TECHNICAL',
                      'ADMINISTRATION',
                      'ADVOCATE'
                    ],
                    hintText: 'Department',
                    validate: (taskType) {
                      if (taskType == null ||
                          taskType.isEmpty ||
                          taskType == 'Task Type') {
                        return 'Please choose a task type';
                      }
                      _department = taskType;
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),

                  /// add task button
                  AppRoundedButton(
                    onPress: () async => await _validateAndAddTask(),
                    buttonText: 'Add Employee',
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
      await _employeeProvider.addEmployee({
        'username': _username,
        'profession': _profession,
        'email': _email,
        'contactNo': _contactNo,
        'department': _department,
        'joiningDate': _joiningDate,
        'password': _password
      }, context).then((value) async {
        Navigator.pop(context);
      });
      // await _employeeProvider.addEmployee({
      //   'username': 'add'.toString(),
      //   'profession': _profession.toString(),
      //   'email': 'satyendrapal1090@gmail.com'.toString(),
      //   'contactNo': _contactNo.toString(),
      //   'department': _department.toString(),
      //   'joiningDate': _joiningDate.toString(),
      //   'password': _password.toString()
      // }, context).then((value) async {
      //   Navigator.pop(context);
      // });
    }
  }
}
