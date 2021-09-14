import 'package:flutter/material.dart';

class NoWifi extends StatelessWidget {
  final onPressed;

  const NoWifi({Key? key, @required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.vertical,
        children: [
          Icon(
            Icons.wifi_off_outlined,
            size: 60,
          ),
          TextButton(
            onPressed: onPressed,
            child: Text(
              "Retry",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          )
        ],
      ),
    );
  }
}
