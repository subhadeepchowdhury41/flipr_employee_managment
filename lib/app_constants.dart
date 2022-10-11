import 'package:flutter/material.dart';

TextStyle kHintTextStyle = TextStyle(
  fontSize: 16,
  color: Colors.grey.shade500,
  fontWeight: FontWeight.w500,
);
BoxDecoration kContainerElevationDecoration = BoxDecoration(
  border: Border.all(
    color: Colors.grey.shade500,
  ),
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.shade400,
      offset: const Offset(0.5, 0.5), //(x,y)
      blurRadius: 0.5,
    ),
    BoxShadow(
      color: Colors.grey.shade400,
      offset: const Offset(-0.5, -0.5), //(x,y)
      blurRadius: 0.5,
    ),
  ],
);
