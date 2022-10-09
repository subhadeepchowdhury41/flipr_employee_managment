import 'package:flipr_employee_managment/app_services/auth/auth_services.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  late String userId;

  logIn({required BuildContext context, required String username,
     required String password}) async {
    AuthServices.signInWithUsernameAndPassword(username: username,
        password: password).then((user) {
          if (user == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something went wrong')));
          } else {
            if (user['err_msg'] == null) {
              if (user['role'] == 'employee') {
                debugPrint("employee");
              } else {
                debugPrint("admin");
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(user['err_msg'])));
            }

          }
    });
  }
}