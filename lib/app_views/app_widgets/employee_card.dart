import 'package:flipr_employee_managment/app_models/user_model.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';

import '../../app_models/task_model.dart';

class EmployeeCard extends StatelessWidget {
  final User employee;
  final Function() navigate;
  const EmployeeCard({
    Key? key,
    required this.navigate,
    required this.employee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      child: GestureDetector(
        onTap: navigate,
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
                ListTileWidget(
                  leading: const Icon(Icons.person, color: Colors.blue),
                  title: Text(
                    employee.username,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ListTileWidget(
                      leading: const Icon(Icons.account_balance_outlined,
                          color: Colors.black),
                      title: Text(
                        employee.department,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    ListTileWidget(
                      leading: const Icon(Icons.person, color: Colors.black),
                      title: Text(
                        employee.role,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
                ListTileWidget(
                  leading: const Icon(Icons.phone, color: Colors.green),
                  title: Text(
                    employee.contactNo,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListTileWidget(
                  leading: const Icon(Icons.email, color: Colors.purple),
                  title: Text(
                    employee.email,
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
