import 'package:flipr_employee_managment/app_views//app_widgets/app_input_field.dart';
import 'package:flipr_employee_managment/app_views/app_widgets/app_rounded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flipr_employee_managment/app_constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          alignment: Alignment.center,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 34,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 25),

                /// username
                AppTextInputWidget(
                  textEditingController: _usernameTextEditingController,
                  validate: (dynamic value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add username';
                    }
                    return null;
                  },
                  hintText: 'Username',
                ),
                const SizedBox(height: 15),

                /// password
                AppTextInputWidget(
                  textEditingController: _passwordTextEditingController,
                  isPassword: true,
                  validate: (dynamic value) {
                    if (value == null || value.isEmpty) {
                      return 'Please add password';
                    }
                    return null;
                  },
                  hintText: 'Password',
                ),
                const SizedBox(height: 25),

                /// submitButton
                AppRoundedButton(
                  onPress: () async {
                    // todo: login button
                    await _validateLoginPage();
                  },
                  buttonText: 'Login',
                ),
                const SizedBox(height: 15),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validateLoginPage() async {
    if (_formKey.currentState!.validate()) {
      /// todo: find user in database
    }
  }
}
