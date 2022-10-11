import 'package:flipr_employee_managment/app_utils/http_requsets.dart';
import 'package:flutter/cupertino.dart';

class AdminServices {
  static Future<List<Map<String, dynamic>>> getAllEmployees() async {
    List<Map<String, dynamic>> employees = [];
    await HttpRequests.sendGetRequest(url: 'auth/employees').then((result) {
      debugPrint(result.toString());
      if (result != null) {
        employees = [...result['employees']];
      }
    });
    // debugPrint('......$employees');
    return employees.where((element) {
      return element['role'] == 'employee';
    }).toList();
  }

  static Future<String?> addEmployee(
      {required Map<String, dynamic> empData}) async {
    String? result;
    await HttpRequests.sendPostRequest(url: 'auth/signup', body: empData)
        .then((response) {
      if (response != null) {
        if (response.containsKey('result')) {
          if (response['result'].toString().contains('success')) {
            result = "Success";
          } else {
            result = response['result'];
          }
        }
      }
    });
    return result;
  }

  /// update employee
  static Future<String?> updateEmployee(
      {required String id, required Map<String, dynamic> empData}) async {
    String? result;

    debugPrint('\nempData --> $empData\n');
    await HttpRequests.sendPutRequest(url: 'auth/employee/$id', body: empData)
        .then((response) {
      if (response != null) {
        if (response.containsKey('result')) {
          if (response['result'].toString().contains('success')) {
            result = "Success";
          } else {
            result = response['result'];
          }
        }
      }
    });
    return result;
  }

  /// delete employee
  static Future<List<Map<String, dynamic>>> deleteEmployee(
      String employeeId) async {
    List<Map<String, dynamic>> employees = [];

    debugPrint('deleting employee --> $employeeId\n\n');
    await HttpRequests.sendDeleteRequest(
            url: 'auth/employee/delete/$employeeId')
        .then((result) {
      debugPrint(result.toString());
      if (result != null) {
        employees = [...result['employees']];
      }
    });
    return employees;
  }
}
