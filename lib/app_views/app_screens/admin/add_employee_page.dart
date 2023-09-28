import 'package:flipr_employee_managment/app_views/app_widgets/app_input_field.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/app_rounded_button.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/date_picker.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/dropdown_input.dart';
import 'package:flutter/material.dart' hide DropdownMenu;
import 'package:provider/provider.dart';

import '../../../app_providers/admin/employee_provider.dart';

class AddEmployeePage extends StatefulWidget {
  final Function() onAdd;
  const AddEmployeePage({
    Key? key,
    required this.onAdd,
  }) : super(key: key);

  @override
  State<AddEmployeePage> createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late EmployeeProvider _employeeProvider;
  bool _isLoading = false;

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
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 25),

                  /// user email
                  AppTextInputWidget(
                    validate: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'Please add email';
                      } else {
                        bool emailValid = RegExp(
                                r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                            .hasMatch(val);
                        if (!emailValid) {
                          return 'Please enter a valid email';
                        }
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
                      } else {
                        bool validPhone = RegExp(
                                r'(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)')
                            .hasMatch(val);
                        if (!validPhone) {
                          return 'Please enter a valid phone number';
                        }
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
                        return 'Please add profession';
                      }
                      _profession = val;
                      return null;
                    },
                    hintText: 'profession',
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
                        return 'Please choose a department';
                      }
                      _department = taskType;
                      return null;
                    },
                  ),
                  const SizedBox(height: 25),

                  /// add employee button
                  _isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(
                              strokeWidth: 5,
                              semanticsLabel: 'Adding Employee',
                              backgroundColor: Colors.blueAccent,
                            ),
                            SizedBox(width: 25),
                            Text(
                              'Adding Employee',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24,
                                color: Colors.green,
                              ),
                            )
                          ],
                        )
                      : AppRoundedButton(
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
      setState(() {
        _isLoading = true;
      });
      await _employeeProvider.addEmployee({
        'username': _username,
        'profession': _profession,
        'email': _email,
        'contactNo': _contactNo,
        'department': _department,
        'joiningDate': _joiningDate,
        'password': _password
      }, context).then((value) async {
        setState(() {
          _isLoading = false;
        });
        widget.onAdd();
        Navigator.pop(context);
      });
    }
  }
}
