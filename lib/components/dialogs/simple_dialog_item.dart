import 'package:flutter/material.dart';

class SimpleDialogItem extends StatelessWidget {
  final icon;
  final iconColor;
  final itemName;
  final Function onClick;

  const SimpleDialogItem({
    Key key,
    this.icon,
    this.iconColor,
    this.itemName,
    this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 32.0),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              itemName,
              style: TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
      onPressed: () {
        Navigator.pop(context);
        return onClick();
      },
    );
  }
}
