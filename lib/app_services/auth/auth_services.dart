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

  /// update user profile
  static Future<Map<String, dynamic>?> updateEmployeeProfile(
      {required Map<String, dynamic> profile, required String id}) async {
    Map<String, dynamic>? user = {};
    await HttpRequests.sendPutRequest(
            url: 'auth/employee/$id', body: profile, requiresAccess: false)
        .then((userDetails) async {
      if (userDetails!.containsKey('message')) {
        user!['err_msg'] = userDetails['message'];
      } else {
        user = userDetails;
      }
    });
    return user;
  }
}
