import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  const DialogButton({
    Key key,
    this.buttonText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => onPressed(),
      child: Text(buttonText),
    );
  }
}
