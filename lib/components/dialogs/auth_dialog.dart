import 'package:bytebank/bytebank.dart';
import 'package:flutter/material.dart';

const String _alertTitle = 'Authenticate';
const String _alertConfirm = 'Confirm';
const String _alertCancel = 'Cancel';

class AuthDialog extends StatefulWidget {
  final Function onConfirm;

  const AuthDialog({Key key, this.onConfirm}) : super(key: key);

  @override
  _AuthDialogState createState() => _AuthDialogState();
}

class _AuthDialogState extends State<AuthDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(_alertTitle),
      content: TextField(
        controller: _controller,
        obscureText: true,
        maxLength: 4,
        decoration: InputDecoration(border: OutlineInputBorder()),
        style: TextStyle(fontSize: 64, letterSpacing: 24),
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
      ),
      actions: [
        DialogButton(
          buttonText: _alertCancel,
          onPressed: () => Navigator.pop(context),
        ),
        DialogButton(
          buttonText: _alertConfirm,
          onPressed: () {
            widget.onConfirm(_controller.text);
            return Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
