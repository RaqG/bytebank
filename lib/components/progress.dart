import 'package:flutter/material.dart';

const String _loadingText = 'Loading...';

class Progress extends StatelessWidget {
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
            child: Text(_loadingText),
          ),
        ],
      ),
    );
  }
}
