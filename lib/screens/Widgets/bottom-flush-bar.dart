import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future bottomFlushBar(BuildContext context, String title) {
  return Flushbar(
    backgroundColor: Colors.black.withOpacity(0.9),
    messageText: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 15),
        ),
      ],
    ),
    duration: Duration(seconds: 3),
  ).show(context);
}
