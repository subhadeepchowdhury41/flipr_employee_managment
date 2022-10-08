import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../app_constants.dart';

class AppTextInputWidget extends StatefulWidget {
  final Function(String? value) validate;
  const AppTextInputWidget({
    Key? key,
    required this.validate,
  }) : super(key: key);

  @override
  State<AppTextInputWidget> createState() => _AppTextInputWidgetState();
}

class _AppTextInputWidgetState extends State<AppTextInputWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: containerElevationDecoration,
      child: FormField(
        initialValue: _textEditingController,
        validator: (val) {
          return widget.validate(_textEditingController.text);
        },
        autovalidateMode: AutovalidateMode.disabled,
        builder: (formState) {
          return Column(
            children: [
              TextField(
                controller: _textEditingController,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  hintText: 'Username',
                  hintStyle: kHintTextStyle,

                  // isDense: true, // Added this
                ),
              ),
              if (formState.hasError)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: CupertinoColors.systemRed,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        formState.errorText!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: CupertinoColors.systemRed,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
