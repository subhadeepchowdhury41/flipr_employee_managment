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
        .then((userDetails) {
      if (userDetails != null) {
        if (userDetails['access_token'] == null) {
          debugPrint('.....${userDetails.toString()}');
          user!['err_msg'] = userDetails['message'];
        } else {
          SharedPreferenceServices.setLoginCredentials(
              accessToken: userDetails['access_token'],
              refreshToken: userDetails['refresh_token']);
          user = userDetails;
        }
      }
    });
    return user;
  }

  static Future<Map<String, dynamic>?> addEmployee(
      {required Map<String, dynamic> empData}) async {
    await HttpRequests.sendPostRequest(url: 'auth/signup', body: empData)
        .then((response) {
          if(response)
    });
    return null;
  }
}
