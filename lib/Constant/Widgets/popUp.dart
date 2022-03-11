import 'package:flutter/material.dart';
import 'package:mangalo_app/Constant/Value/value_constant.dart';

class StatusDialogue extends StatelessWidget {
  final String contentString;
  final Color stringColor;
  const StatusDialogue(
      {Key? key, required this.contentString, required this.stringColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 5,
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              contentString,
              textAlign: TextAlign.center,
              maxLines: 4,
              style: TextStyle(color: stringColor, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
