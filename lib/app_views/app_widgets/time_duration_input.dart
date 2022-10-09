import 'package:flipr_employee_managment/app_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeDurationInputWidget extends StatefulWidget {
  final String? Function(String? value, String timeType) validate;
  final String? hintText;
  final bool isPassword;
  final TextInputType keyboardType;
  const TimeDurationInputWidget({
    Key? key,
    required this.validate,
    this.isPassword = false,
    this.hintText,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  State<TimeDurationInputWidget> createState() =>
      _TimeDurationInputWidgetState();
}

class _TimeDurationInputWidgetState extends State<TimeDurationInputWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isVisible = false;
  String _timeType = 'hrs';

  @override
  void initState() {
    _isVisible = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(left: 10),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: kContainerElevationDecoration,
      child: FormField(
        initialValue: _textEditingController,
        validator: (val) {
          return widget.validate(_textEditingController.text, _timeType);
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        builder: (formState) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 8,
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
                      keyboardType: widget.keyboardType,
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: TextButton(
                        child: Text(
                          _timeType,
                          style: const TextStyle(
                            fontWeight: FontWeight.w700,
                            // color:
                          ),
                        ),
                        onPressed: () {
                          if (_timeType == 'HRS') {
                            // setState(() {
                            _timeType = 'MIN';
                            // });
                          } else {
                            _timeType = 'HRS';
                          }
                          setState(() {
                            _timeType;
                          });
                        },
                      )),
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
