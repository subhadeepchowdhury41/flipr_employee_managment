import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_constants.dart';

class DropdownMenu extends StatefulWidget {
  final String? Function(String? value) validate;
  final String? hintText;
  final List<String> taskTypes;
  const DropdownMenu({
    Key? key,
    required this.taskTypes,
    required this.hintText,
    required this.validate,
  }) : super(key: key);

  @override
  State<DropdownMenu> createState() => _DropdownMenuState();
}

class _DropdownMenuState extends State<DropdownMenu> {
  late final List<dynamic> items;
  dynamic currentValue;

  @override
  void initState() {
    _initializeOptionList();
    super.initState();
  }

  void _initializeOptionList() {
    items = ['${widget.hintText}'];
    items.addAll(widget.taskTypes);
    currentValue = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: kContainerElevationDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            initialValue: currentValue,
            validator: (currentOption) {
              return widget.validate(currentOption.toString());
            },
            builder: (formState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButton<dynamic>(
                    hint: Text(
                      '${widget.hintText}',
                      style: kHintTextStyle,
                    ),
                    value: currentValue,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      size: 40,
                      color: CupertinoColors.black,
                    ),
                    items: items.map(
                      (option) {
                        return DropdownMenuItem(
                          value: option,
                          onTap: () => setState(() {
                            debugPrint('value selected --> $option');
                          }),
                          child: Text(
                            option,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: option == '${widget.hintText}'
                                  ? Colors.grey.shade500
                                  : Colors.black,
                            ),
                          ),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      setState(() {
                        currentValue = value;
                      });

                      formState.didChange(currentValue);
                    },
                    isExpanded: true,
                  ),
                  if (formState.hasError)
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 8),
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
        ],
      ),
    );
  }
}
