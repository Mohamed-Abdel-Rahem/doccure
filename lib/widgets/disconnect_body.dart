// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class DisconnectedBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Connection lost. Please check your internet connection.',
        style: TextStyle(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
