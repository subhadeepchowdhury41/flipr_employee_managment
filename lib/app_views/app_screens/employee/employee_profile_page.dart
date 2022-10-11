import 'package:flipr_employee_managment/app_providers/common/auth_provider.dart';
import 'package:flipr_employee_managment/app_services/auth/auth_services.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/app_text_display.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app_models/user_model.dart';
import '../../app_widgets/app_input_field.dart';
import '../../app_widgets/app_rounded_button.dart';

class EmployeeProfilePage extends StatefulWidget {
  const EmployeeProfilePage({Key? key}) : super(key: key);

  @override
  State<EmployeeProfilePage> createState() => _EmployeeProfilePageState();
}

class _EmployeeProfilePageState extends State<EmployeeProfilePage> {
  late AuthProvider _authProvider;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _password;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    _authProvider = Provider.of<AuthProvider>(context);
    super.didChangeDependencies();
  }

  Future<User?> _getUserProfile() async {
    return _authProvider.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Password'),
      ),
      body: SingleChildScrollView(
        child: Container(
          // color: Colors.red,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: FutureBuilder(
            future: _getUserProfile(),
            builder: (context, AsyncSnapshot<User?> user) {
              if (user.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (user.hasData) {
                  // List<Task>? tasks = snapshot.data;
                  return Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /// username
                        TextDisplay(
                            hintText: 'Username : ${user.data!.username}'),
                        const SizedBox(height: 25),

                        /// user email
                        TextDisplay(hintText: 'Email : ${user.data!.email}'),
                        const SizedBox(height: 25),

                        /// contact number
                        TextDisplay(
                            hintText: 'Phone No. : ${user.data!.contactNo}'),
                        const SizedBox(height: 25),

                        /// role
                        TextDisplay(
                            hintText: 'Role : ${user.data!.profession}'),
                        const SizedBox(height: 25),

                        /// joining date
                        TextDisplay(
                            hintText:
                                'Joining Date : ${user.data!.joiningDate}'),
                        const SizedBox(height: 25),

                        /// department
                        TextDisplay(
                            hintText: 'Department : ${user.data!.department}'),
                        const SizedBox(height: 25),

                        /// password
                        AppTextInputWidget(
                          validate: (String? val) {
                            if (val == null || val.isEmpty) {
                              return 'Please add a password';
                            }
                            _password = val;
                            return null;
                          },
                          hintText: 'new password',
                          isPassword: true,
                          keyboardType: TextInputType.visiblePassword,
                        ),
                        const SizedBox(height: 25),

                        /// add task button
                        _isLoading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(
                                    strokeWidth: 5,
                                    semanticsLabel: 'Updating Password',
                                    backgroundColor: Colors.blueAccent,
                                  ),
                                  SizedBox(width: 25),
                                  Text(
                                    'Updating Password',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 24,
                                      color: Colors.green,
                                    ),
                                  )
                                ],
                              )
                            : AppRoundedButton(
                                onPress: () async =>
                                    await _validateAndUpdateProfile(),
                                buttonText: 'Update Password',
                              ),
                      ],
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }
            },
          ),
        ),
      ),
    );
  }

  /// TODO: UPDATE EMPLOYEE PROFILE
  Future<void> _validateAndUpdateProfile() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      await AuthServices.updateEmployeeProfile(profile: {
        'password': _password,
      }, id: _authProvider.userId)
          .then((user) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password Updated Successfully'),
          ),
        );

        setState(() {
          _password = null;
          _isLoading = false;
        });

        debugPrint('user after update --> $user\n\n');
      });
    }
  }
}
