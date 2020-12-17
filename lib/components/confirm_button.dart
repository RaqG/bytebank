import 'package:flutter/material.dart';

class ConfirmButton extends StatelessWidget {
final String buttonText;
  final Function onPressed;

  const ConfirmButton({
    Key key,
    @required this.buttonText,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        width: double.maxFinite,
        child: RaisedButton(
          child: Text(buttonText),
          onPressed: () => onPressed(),
        ),
      ),
    );
  }
}