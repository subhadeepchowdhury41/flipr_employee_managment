import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app_constants.dart';

class DropdownMenu extends StatefulWidget {
  final String? Function(String? value) validate;
  final String? hintText;
  final List<String> taskTypes;
  final TextEditingController textEditingController;
  const DropdownMenu({
    Key? key,
    required this.taskTypes,
    required this.textEditingController,
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
    items = [
      {
        'id': '-1',
        'value': 'Choose',
      }
    ];
    items.addAll(widget.taskTypes);
    widget.textEditingController.text = items[0];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      margin: const EdgeInsets.only(bottom: 15),
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
                  Container(
                    margin: const EdgeInsets.only(top: 15),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 2.5),
                    decoration: kContainerElevationDecoration.copyWith(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade500,
                          offset: const Offset(0.0, 0.5), //(x,y)
                          blurRadius: 0.0,
                        ),
                      ],
                    ),
                    child: DropdownButton<dynamic>(
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
                                fontSize: 14,
                                color: option == '${widget.hintText}'
                                    ? Colors.grey.shade600
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
