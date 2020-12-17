import 'package:flutter/material.dart';

class FeatureItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onPushScreen;

  const FeatureItem({
    Key key,
    this.title,
    this.icon,
    @required this.onPushScreen,
  })  : assert(icon != null),
        assert(onPushScreen != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).primaryColor,
        child: InkWell(
          onTap: () => onPushScreen(),
          child: Container(
            height: 100,
            width: 160,
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 24.0,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
