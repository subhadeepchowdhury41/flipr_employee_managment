import 'package:flipr_employee_managment/app_models/user_model.dart';
import 'package:flipr_employee_managment/app_providers/admin/employee_provider.dart';
import 'package:flipr_employee_managment/app_services/auth/auth_services.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/list_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_models/task_model.dart';

class EmployeeCard extends StatefulWidget {
  final User employee;
  final Function() navigate;
  final Function() onChanged;
  const EmployeeCard({
    Key? key,
    required this.navigate,
    required this.employee,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  late bool _isActive;
  late EmployeeProvider _employeeProvider;

  Future<void> _updateEmployeeStatus() async {
    Map<String, dynamic> user = {
      // 'username': widget.employee.username,
      // 'profession': widget.employee.profession,
      // 'email': widget.employee.email,
      // 'contactNo': widget.employee.contactNo,
      // 'department': widget.employee.department,
      // 'joiningDate': widget.employee.joiningDate,
      // 'password': widget.employee.password,
      'active': _isActive,
    };

    await AuthServices.updateEmployee(id: widget.employee.id, empData: user);
  }

  void _changeStatus() {
    setState(() {
      _isActive = !_isActive;
    });
  }

  @override
  void didChangeDependencies() {
    _employeeProvider = Provider.of<EmployeeProvider>(context);
    _isActive = widget.employee.isActive;
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    _isActive = widget.employee.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      child: GestureDetector(
        onTap: widget.navigate,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 8,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ListTileWidget(
                        leading: const Icon(Icons.person, color: Colors.blue),
                        title: Text(
                          widget.employee.username,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: PopupMenuButton(
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            value: 0,
                            onTap: () async {
                              /// TODO: UPDATE EMPLOYEE
                              _changeStatus();
                              await _updateEmployeeStatus().then((value) {
                                widget.onChanged();
                              });
                            },
                            // padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              _isActive ? 'Deactivate' : 'Activate',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: CupertinoColors.white,
                              ),
                            ),
                          ),
                        ],
                        // padding: const EdgeInsets.all(2.5),
                        elevation: 12,
                        color: _isActive ? Colors.red : Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(
                            color: _isActive ? Colors.red : Colors.green,
                            width: 2.8,
                          ),
                        ),
                        child: Icon(
                          Icons.circle,
                          color: _isActive ? Colors.green : Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListTileWidget(
                        leading: const Icon(Icons.account_balance_outlined,
                            color: Colors.black),
                        title: Text(
                          widget.employee.department,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 25),
                    Expanded(
                      child: ListTileWidget(
                        leading: const Icon(Icons.person, color: Colors.black),
                        title: Text(
                          widget.employee.profession,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                    // const SizedBox(width: 25),
                  ],
                ),
                ListTileWidget(
                  leading: const Icon(Icons.phone, color: Colors.green),
                  title: Text(
                    widget.employee.contactNo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTileWidget(
                  leading: const Icon(Icons.email, color: Colors.purple),
                  title: Text(
                    widget.employee.email,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
