import 'package:flutter/cupertino.dart';

class ListTileWidget extends StatelessWidget {
  final Widget leading, title;

  const ListTileWidget({
    Key? key,
    required this.title,
    required this.leading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          leading,
          const SizedBox(width: 10),
          title,
        ],
      ),
    );
  }
}
