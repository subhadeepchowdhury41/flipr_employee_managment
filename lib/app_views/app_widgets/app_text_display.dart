import 'package:flipr_employee_managment/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextDisplay extends StatefulWidget {
  final String hintText;

  const TextDisplay({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  State<TextDisplay> createState() => _TextDisplayState();
}

class _TextDisplayState extends State<TextDisplay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 10),
      width: double.infinity,
      // height: 50,
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: kContainerElevationDecoration.copyWith(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            offset: const Offset(0.5, 0.5), //(x,y)
            blurRadius: 1.5,
          ),
          BoxShadow(
            color: Colors.grey.shade400,
            offset: const Offset(-0.5, -0.5), //(x,y)
            blurRadius: 0.5,
          ),
        ],
      ),
      child: Text(
        widget.hintText,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade800,
        ),
        softWrap: true,
      ),
    );
  }
}
