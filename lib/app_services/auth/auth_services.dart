import 'package:flipr_employee_managment/app_services/database/shared_preference.dart';
import 'package:flipr_employee_managment/app_utils/http_requsets.dart';
import 'package:flutter/cupertino.dart';

class AuthServices {
  static Future<Map<String, dynamic>?> signInWithUsernameAndPassword(
      {required String username, required String password}) async {
    Map<String, dynamic>? user = {};
    await HttpRequests.sendPostRequest(
            url: 'auth/signin',
            body: {'username': username, 'password': password},
            requiresAccess: false)
        .then((userDetails) async {
      if (userDetails!.containsKey('message')) {
        user!['err_msg'] = userDetails['message'];
      } else {
        print(userDetails);
        SharedPreferenceServices.setLoginCredentials(
            accessToken: userDetails['accessToken'],
            refreshToken: userDetails['refreshToken']);
        user = userDetails;
      }
    });
    return user;
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
}
