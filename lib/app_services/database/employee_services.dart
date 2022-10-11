import 'package:flipr_employee_managment/app_models/task_model.dart';
import 'package:flipr_employee_managment/app_utils/http_requsets.dart';
import 'package:flutter/cupertino.dart';

class EmployeeServices {
  /// adding the task
  static Future<String?> addTask(
      Map<String, dynamic> body, String employeeId) async {
    String result = '';
    await HttpRequests.sendPostRequest(url: 'task/add/$employeeId', body: body)
        .then((value) {
      if (value != null) {
        result = value['result'];
      }
    });
    if (result == '') {
      return null;
    }
    return result;
  }

  /// for deleting of task
  static Future<String?> deleteTask(
      Map<String, dynamic> body, String employeeId, String taskId) async {
    String result = '';
    await HttpRequests.sendDeleteRequest(url: 'task/delete/$taskId', body: body)
        .then((value) {
      if (value != null) {
        result = value['result'];
      }
    });
    if (result == '') {
      return null;
    }
    return result;
  }

  /// for getting the list of all tasks
  static Future<List<Task>> getTasks(String id) async {
    List<Task> tasks = [];
    await HttpRequests.sendGetRequest(url: 'tasks/$id').then((data) {
      if (data != null) {
        debugPrint('tasks --> $data\n');
        tasks = [...data['tasks'].map((e) => Task.fromJson(e)).toList()];
      }
    });
    return tasks;
  }
}
