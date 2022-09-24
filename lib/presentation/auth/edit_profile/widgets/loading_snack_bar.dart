import 'package:flutter/material.dart';

buildLoadingSnackBar() {
  return SnackBar(
    content: Row(
      children: [
        CircularProgressIndicator(),
        SizedBox(width: 10),
        Text('Loading...'),
      ],
    ),
  );
}
