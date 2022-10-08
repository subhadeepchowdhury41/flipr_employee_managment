import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_constants.dart';

class AppTextInputWidget extends StatefulWidget {
  final String? Function(dynamic value) validate;
  final String? hintText;
  final bool isPassword;

  const AppTextInputWidget({
    Key? key,
    required this.validate,
    this.isPassword = false,
    this.hintText,
  }) : super(key: key);

  @override
  State<AppTextInputWidget> createState() => _AppTextInputWidgetState();
}

class _AppTextInputWidgetState extends State<AppTextInputWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isVisible = false;

  @override
  void initState() {
    _isVisible = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: kContainerElevationDecoration,
      child: FormField(
        initialValue: _textEditingController,
        validator: (val) {
          return widget.validate(_textEditingController.text);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (formState) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      onChanged: (val) {
                        formState.didChange(_textEditingController);
                      },
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        hintText: widget.hintText ?? '',
                        hintStyle: kHintTextStyle,
                      ),
                      obscureText: _isVisible,
                    ),
                  ),
                  if (widget.isPassword)
                    IconButton(
                      onPressed: () {
                        setState(() {
                          _isVisible = !_isVisible;
                        });
                      },
                      icon: _isVisible
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                    ),
                ],
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
