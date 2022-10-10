import 'package:flipr_employee_managment/app_models/user_model.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/list_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_models/task_model.dart';

class EmployeeCard extends StatefulWidget {
  final User employee;
  final Function() navigate;
  const EmployeeCard({
    Key? key,
    required this.navigate,
    required this.employee,
  }) : super(key: key);

  @override
  State<EmployeeCard> createState() => _EmployeeCardState();
}

class _EmployeeCardState extends State<EmployeeCard> {
  bool _isActive = true;

  Future<void> _updateEmployeeStatus() async {
    _changeStatus();
  }

  void _changeStatus() {
    setState(() {
      _isActive = !_isActive;
    });
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
                // ListTileWidget(
                //   leading: const Icon(Icons.perm_identity, color: Colors.red),
                //   title: Text(
                //     employee.id,
                //     style: const TextStyle(
                //       fontWeight: FontWeight.w500,
                //       fontSize: 16,
                //     ),
                //   ),
                // ),
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
                              _updateEmployeeStatus();
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
