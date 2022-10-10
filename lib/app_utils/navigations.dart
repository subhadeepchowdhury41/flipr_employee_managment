import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation {
  static void pushReplacement(BuildContext context, Widget page) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder) => page));
  }
}