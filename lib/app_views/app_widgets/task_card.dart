import 'package:flipr_employee_managment/app_views/app_widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';

import '../../app_models/task_model.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final Function() navigate;
  const TaskCard({
    Key? key,
    required this.navigate,
    required this.task,
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
                ListTileWidget(
                  leading: const Icon(Icons.calendar_month, color: Colors.blue),
                  title: Text(
                    task.date,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
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
                  title: Text(
                    task.description,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
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
