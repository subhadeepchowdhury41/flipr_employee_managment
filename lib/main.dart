import 'package:flipr_employee_managment/app_providers/common/auth_provider.dart';
import 'package:flipr_employee_managment/app_providers/task_provider.dart';
import 'package:flipr_employee_managment/app_views/app_screens/admin/admin_dashboard.dart';
import 'package:flipr_employee_managment/app_views/app_screens/employee/employee_task_page.dart';
import 'package:flipr_employee_managment/app_views/app_screens/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_providers/admin/employee_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (context) => AuthProvider()),
        ChangeNotifierProvider<TaskProvider>(
            create: (context) => TaskProvider()),
        ChangeNotifierProvider<EmployeeProvider>(
            create: (context) => EmployeeProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: const EmployeeAddTaskPage(),
        // home: const TasksChartPage(),
        // home: const LoginPage(),
        // home: EmployeeTaskPage(),
        home: LoginPage(),
      ),
    );
  }
}
