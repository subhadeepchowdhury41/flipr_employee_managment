import 'package:flipr_employee_managment/app_services/auth/auth_services.dart';
import 'package:flipr_employee_managment/app_services/database/admin_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_models/user_model.dart';
import '../app_models/task_model.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _taskList = [];

  // getter
  List<Task> get taskList {
    return [..._taskList];
  }

  // setter
  void setEmployeeList(List<Task> tasks) {
    _taskList = [...tasks];
    notifyListeners();
  }

  bool isLoading = false;

  Future<bool> fetchTasks() async {
    List<Map<String, dynamic>> list = await AdminServices.getAllEmployees();

    for (var user in list) {
      _taskList.add(Task.fromJson(user));
    }
    return true;
  }

  Future<void> addTask(Map<String, dynamic> data, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await AuthServices.addEmployee(empData: data).then((result) async {
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something went wrong")));
      } else {
        if (result == 'Success') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Employee added successfully")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
        }
      }
      await fetchTasks().whenComplete(() {
        isLoading = false;
        notifyListeners();
      });
    });
  }

  /// filter task list for a specific day
  Future<void> filterTaskListFromDate(String date) async {
    notifyListeners();
  }
}
