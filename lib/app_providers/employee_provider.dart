import 'package:flutter/cupertino.dart';

import '../app_models/task_model.dart';
import '../app_models/user_model.dart';

class EmployeeProvider extends ChangeNotifier {
  final List<User> _employeeList = [
    User(
      id: '1',
      username: 'satendra pal',
      role: 'it',
      email: 'satyendrapal565@gmail.com',
      contactNo: '9335828140',
      department: 'it',
      joiningDate: '10/09/2022',
    ),
    User(
      id: '1',
      username: 'satendra pal',
      role: 'it',
      email: 'satyendrapal565@gmail.com',
      contactNo: '9335828140',
      department: 'it',
      joiningDate: '10/09/2022',
    ),
    User(
      id: '1',
      username: 'satendra pal',
      role: 'it',
      email: 'satyendrapal565@gmail.com',
      contactNo: '9335828140',
      department: 'it',
      joiningDate: '10/09/2022',
    ),
    User(
      id: '1',
      username: 'satendra pal',
      role: 'it',
      email: 'satyendrapal565@gmail.com',
      contactNo: '9335828140',
      department: 'it',
      joiningDate: '10/09/2022',
    ),
  ];
  List<User> get employeeList {
    return [..._employeeList];
  }

  bool isLoading = false;

  Future<void> updateTaskList() async {}

  Future<void> setTasksList() async {}

  /// method for adding task in databases
  Future<void> addEmployee(Map<String, dynamic> userData) async {
    userData['id'] = '1';
    User newUser = User.fromJson(userData);
    // TODO: ADD Employee TO DATABASE

    _employeeList.add(newUser);
    notifyListeners();
  }

  /// filter task list for a specific day
  Future<void> filterTaskListFromDate(String date) async {
    notifyListeners();
  }
}