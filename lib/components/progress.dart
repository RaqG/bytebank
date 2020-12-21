import 'package:flutter/material.dart';

const String _loadingText = 'Loading...';

class Progress extends StatelessWidget {
  final String message;

  const Progress({
    Key key,
    this.message = _loadingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
        ],
      ),
    );
  }
}
