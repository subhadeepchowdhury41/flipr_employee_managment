import 'package:flipr_employee_managment/app_services/database/employee_services.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/list_tile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function() onDelete;
  final String employeeId;
  const TaskCard({
    Key? key,
    required this.onDelete,
    required this.task,
    required this.employeeId,
  }) : super(key: key);

  Future<void> _deleteTask() async {
    await EmployeeServices.deleteTask({}, employeeId, task.id)
        .then((value) => onDelete);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3, bottom: 3, left: 10, right: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                      leading:
                          const Icon(Icons.calendar_month, color: Colors.blue),
                      title: Text(
                        task.date,
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
                            /// Delete Task
                            await _deleteTask().then((value) => onDelete());
                          },
                          // padding: const EdgeInsets.only(left: 8.0),
                          child: const Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: CupertinoColors.white,
                            ),
                          ),
                        ),
                      ],
                      // padding: const EdgeInsets.all(2.5),
                      elevation: 12,
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: const BorderSide(
                          color: Colors.red,
                          width: 2.8,
                        ),
                      ),
                      child: const Icon(
                        Icons.more_vert,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              ListTileWidget(
                leading: const Icon(Icons.watch_later, color: Colors.brown),
                title: Text(
                  task.startTime,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListTileWidget(
                    leading: const Icon(Icons.timeline, color: Colors.red),
                    title: Text(
                      task.taskDuration,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  ListTileWidget(
                    leading:
                        const Icon(Icons.type_specimen, color: Colors.purple),
                    title: Text(
                      task.taskType,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              ListTileWidget(
                leading: const Icon(Icons.description, color: Colors.green),
                title: Expanded(
                  child: Text(
                    task.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
