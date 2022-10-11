import 'package:flipr_employee_managment/app_models/user_model.dart';
import 'package:flipr_employee_managment/app_services/database/admin_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_widgets/employee_card.dart';
import 'add_employee_page.dart';
import 'employee_charts_page.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({Key? key}) : super(key: key);

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {

  String? _date;

  @override
  void initState() {
    DateTime currDate = DateTime.now();
    _date = '${currDate.day}/${currDate.month}/${currDate.year}';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Container(
        // color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: FutureBuilder(
          future: AdminServices.getAllEmployees(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return EmployeeCard(
                      employee: User.fromJson(snapshot.data![index]),
                      navigate: () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => EmployeeChartPage(
                              employee: User.fromJson(snapshot.data![index]),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }

            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (context) {
              return const AddEmployeePage();
            }),
          );
        },
        elevation: 10,
        child: const Center(
          child: Icon(Icons.add_task),
        ),
      ),
    );
  }
}
