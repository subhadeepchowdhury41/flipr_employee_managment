import 'package:flipr_employee_managment/app_views/app_screens/employee/employee_dashboard.dart';
import 'package:flipr_employee_managment/app_views/app_screens/employee/employee_profile_page.dart';
import 'package:flipr_employee_managment/app_views/app_screens/employee/employee_task_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmployeeHomePage extends StatefulWidget {
  const EmployeeHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<EmployeeHomePage> createState() => _EmployeeHomePageState();
}

class _EmployeeHomePageState extends State<EmployeeHomePage> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void deactivate() {
    _pageController.dispose();
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<Widget> _getEmployeePages() {
    List<Widget> screen = [
      const EmployeeDashboard(),
      const EmployeeTaskPage(),
      const EmployeeProfilePage(),
    ];

    return screen;
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      children: _getEmployeePages(),
      onPageChanged: (currentPage) {
        debugPrint('page changed --> $currentPage}');
        // _pageController.jumpToPage(currentPage);
      },
    );
  }
}
