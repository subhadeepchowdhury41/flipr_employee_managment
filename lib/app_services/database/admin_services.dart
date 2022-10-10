import 'package:flipr_employee_managment/app_utils/http_requsets.dart';

class AdminServices {
  static Future<List<Map<String, dynamic>>> getAllEmployees() async {
    List<Map<String, dynamic>> employees = [];
    await HttpRequests.sendGetRequest(url: 'auth/employees').then((result) {
      print(result);
      if (result != null) {
        employees = result as List<Map<String, dynamic>>;
      }
    });
    return employees;
  }
}