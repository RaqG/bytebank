import 'package:bytebank/bytebank.dart';
import 'package:flutter/material.dart';

class ResponseDialog extends StatelessWidget {
  final String title;
  final String message;
  final String buttonText;
  final IconData icon;
  final Color colorIcon;

  const ResponseDialog({
    Key key,
    this.title = "",
    this.message = "",
    this.buttonText = 'OK',
    this.icon,
    this.colorIcon = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Visibility(
        visible: title.isNotEmpty,
        child: Text(title),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Icon(
                icon,
                size: 64,
                color: colorIcon,
              ),
            ),
          if (message.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
        ],
      ),
      actions: [
        DialogButton(
          onPressed: () => Navigator.pop(context),
          buttonText: buttonText,
        ),
      ],
    );
  }
}

class SuccessDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const SuccessDialog({
    Key key,
    this.title = 'Success',
    this.message,
    this.icon = Icons.done,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: title,
      message: message,
      icon: icon,
      colorIcon: Colors.green,
    );
  }
}

class FailureDialog extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const FailureDialog({
    Key key,
    this.title = 'Failure',
    this.message,
    this.icon = Icons.warning_outlined,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponseDialog(
      title: title,
      message: message,
      icon: icon,
      colorIcon: Colors.red,
    );
  }
}
