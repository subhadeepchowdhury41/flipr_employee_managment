import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_constants.dart';

class DatePicker extends StatefulWidget {
  final String? Function(DateTime? value) validate;

  const DatePicker({
    Key? key,
    required this.validate,
  }) : super(key: key);

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _date;
  final DateTime _firstDate = DateTime(2000);

  @override
  void initState() {
    _initializeValueFromData();
    super.initState();
  }

  void _initializeValueFromData() {}

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _date = DateTime.now();
  }

  void _showDateTimePicker(FormFieldState formFieldState) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: _firstDate,
      lastDate: DateTime.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _date = value;
          String date = '${_date!.day}/${_date!.month}/${_date!.year}';
        });
        formFieldState.didChange(_date);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: kContainerElevationDecoration,
      child: FormField<DateTime>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: _date,
        validator: (date) {
          return widget.validate(date);
        },
        builder: (formState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        '${_date != null ? _date!.day : 'dd'}/${_date != null ? _date!.month : 'mm'}/${_date != null ? _date!.year : 'yyyy'}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _date == null
                              ? Colors.grey.shade500
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            _date = null;
                          });
                          formState.didChange(_date);
                        },
                        icon: const Icon(
                          Icons.clear,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: IconButton(
                        onPressed: () => _showDateTimePicker(formState),
                        icon: const Icon(
                          Icons.calendar_month,
                          size: 28,
                          color: CupertinoColors.activeBlue,
                        ),
                      ),
                    ),
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
