import 'package:flutter/cupertino.dart';

import '../app_models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasksList = [];
  List<Task> get tasksList {
    return [..._tasksList];
  }

  bool isLoading = false;

  Future<void> updateTaskList() async {}

  Future<void> setTasksList() async {}

  /// method for adding task in databases
  Future<void> addTask(Map<String, dynamic> taskData) async {
    Task newTask = Task.fromJson(taskData);
    // TODO: ADD TASK TO DATABASE

    _tasksList.add(newTask);
    notifyListeners();
  }

  /// filter task list for a specific day
  Future<void> filterTaskListFromDate(String date) async {
    notifyListeners();
  }
}
