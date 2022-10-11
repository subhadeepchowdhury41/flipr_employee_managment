import 'package:flipr_employee_managment/app_services/auth/auth_services.dart';
import 'package:flipr_employee_managment/app_utils/navigations.dart';
import 'package:flipr_employee_managment/app_views/app_screens/admin/admin_dashboard.dart';
import 'package:flipr_employee_managment/app_views/app_screens/employee/employee_dashboard.dart';
import 'package:flipr_employee_managment/app_views/app_screens/employee/employee_home_page.dart';
import 'package:flutter/material.dart';

import '../../app_models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  late String userId;
  late String userRole;
  late User? user;
  bool isLoading = false;

  Future<void> logIn(
      {required BuildContext context,
      required String username,
      required String password}) async {
    await AuthServices.signInWithUsernameAndPassword(
            username: username, password: password)
        .then((user) {
      if (user == null) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something went wrong')));
      } else {
        debugPrint('\nuser from login --> $user\n\n');
        if (user['err_msg'] == null) {
          userId = user['_id'];
          userRole = user['role'];
          this.user = User.fromJson(user);

          if (user['role'] == 'employee') {
            debugPrint("Employee");
            Navigation.pushReplacement(context, const EmployeeHomePage());
          } else {
            debugPrint("Admin");
            Navigation.pushReplacement(context, const AdminDashboardPage());
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(user['err_msg'])));
        }
      }
    });
  }
}
