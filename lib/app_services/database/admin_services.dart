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
    return employees;
  }
}
