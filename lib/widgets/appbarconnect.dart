// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ConnectedAppBar extends StatelessWidget implements PreferredSizeWidget {
  final InAppWebViewController? webViewController;
  final PullToRefreshController? refreshController;

  ConnectedAppBar(
      {required this.webViewController, required this.refreshController});

  @override
  // ignore: prefer_const_constructors
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () async {
          if (await webViewController!.canGoBack()) {
            webViewController!.goBack();
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('No back history item'),
              ),
            );
          }
        },
      ),
      title: const Text(
        'DOCCURE',
        style: TextStyle(
          color: Color.fromARGB(255, 51, 144, 231),
          fontSize: 27,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            webViewController?.reload();
          },
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
