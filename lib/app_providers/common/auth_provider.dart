import 'package:flipr_employee_managment/app_services/auth/auth_services.dart';
import 'package:flipr_employee_managment/app_utils/navigations.dart';
import 'package:flipr_employee_managment/app_views/app_screens/admin/admin_dashboard.dart';
import 'package:flipr_employee_managment/app_views/app_screens/employee/employee_task_page.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  late String userId;
  late String userRole;

  logIn({required BuildContext context, required String username,
     required String password}) async {
    AuthServices.signInWithUsernameAndPassword(username: username,
        password: password).then((user) {
          if (user == null) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Something went wrong')));
          } else {
            if (user['err_msg'] == null) {
              userId = user['id'];
              userRole = user['role'];
              if (user['role'] == 'employee') {
                debugPrint("Employee");
                Navigation.pushReplacement(context, const EmployeeTaskPage());
              } else {
                debugPrint("Admin");
                Navigation.pushReplacement(context, const AdminDashboardPage());
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(user['err_msg'])));
            }

          }
    });
  }
}