// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class DisconnectedAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'DOCCURE',
        style: TextStyle(
          color: Color.fromARGB(255, 51, 144, 231),
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
