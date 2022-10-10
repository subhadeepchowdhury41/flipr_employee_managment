import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_constants.dart';

class TimePicker extends StatefulWidget {
  final String? Function(TimeOfDay? value) validate;

  const TimePicker({
    Key? key,
    required this.validate,
  }) : super(key: key);

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? _timeOfDay;
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
    _timeOfDay = TimeOfDay.now();
  }

  void _showDateTimePicker(FormFieldState formFieldState) {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then((value) {
      if (value != null) {
        setState(() {
          _timeOfDay = value;
          debugPrint('time of day --> ${_timeOfDay}\n');
        });
        formFieldState.didChange(_timeOfDay);
      }
    });
  }

  String _getDayPeriod(DayPeriod period) {
    if (period == DayPeriod.am) {
      return 'AM';
    } else {
      return 'PM';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: kContainerElevationDecoration,
      child: FormField<TimeOfDay>(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: _timeOfDay,
        validator: (time) {
          return widget.validate(time);
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
                        '${_timeOfDay != null ? _timeOfDay!.hour : '00'} : '
                        '${_timeOfDay != null ? _timeOfDay!.minute : '00'} '
                        '${_timeOfDay != null ? _getDayPeriod(_timeOfDay!.period) : 'AM'}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: _timeOfDay == null
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
                            _timeOfDay = null;
                          });
                          formState.didChange(_timeOfDay);
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
                          Icons.watch_later_outlined,
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
