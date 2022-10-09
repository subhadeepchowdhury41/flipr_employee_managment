import 'package:flipr_employee_managment/app_services/database/shared_preference.dart';
import 'package:flipr_employee_managment/app_utils/http_requsets.dart';
import 'package:flutter/cupertino.dart';

class AuthServices {
  static Future<Map<String, dynamic>?> signInWithUsernameAndPassword({required String username,
    required String password}) async {
    await HttpRequests.sendPostRequest(url: 'auth/signin', body: {
      'username': username,
      'password': password
    }, requiresAccess: false).then((user) {
      debugPrint('...${user.toString()}');
      if (user != null) {
        if (user['access_token'] != null) {
          if (user['role'] == null) {
            user['err_msg'] = user['message'];
          } else {
            SharedPreferenceServices.setLoginCredentials(
                accessToken: user['access_token'],
                refreshToken: user['refresh_token']
            );
          }

          return user;
      } else {
          return null;
      }}
    });
    return null;
  }
}
