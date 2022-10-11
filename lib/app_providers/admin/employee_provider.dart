import 'package:flipr_employee_managment/app_services/auth/auth_services.dart';
import 'package:flipr_employee_managment/app_services/database/admin_services.dart';
import 'package:flutter/material.dart';
import '../../app_models/user_model.dart';

class EmployeeProvider extends ChangeNotifier {
  List<User> _employeeList = [];

  // getter
  List<User> get employeeList {
    return [..._employeeList];
  }

  // setter
  void setEmployeeList(List<User> employees) {
    _employeeList = [...employees];
    notifyListeners();
  }

  bool isLoading = false;

  Future<void> fetchEmployees() async {
    List<Map<String, dynamic>> list = await AdminServices.getAllEmployees();

    List<User> listOfUser = list.map((e) {
      User user = User.fromJson(e);
      debugPrint('a user has been created --> ${user.toJson()}');
      return user;
    }).toList();
    _employeeList = [...listOfUser];

    // debugPrint('_employeeList \n ${_employeeList.toString()}');
    // notifyListeners();
  }

  Future<void> addEmployee(
      Map<String, dynamic> data, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await AdminServices.addEmployee(empData: data).then((result) async {
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
      await fetchEmployees().whenComplete(() {
        isLoading = false;
        notifyListeners();
      });
    });
  }

  /// update employee status
  Future<void> updateEmployee(
      Map<String, dynamic> data, String id, BuildContext context) async {
    isLoading = true;
    notifyListeners();
    await AdminServices.updateEmployee(id: id, empData: data)
        .then((result) async {
      if (result == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Something went wrong")));
      } else {
        if (result == 'Success') {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Employee updated successfully")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(result)));
        }
      }
      await fetchEmployees().whenComplete(() {
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
