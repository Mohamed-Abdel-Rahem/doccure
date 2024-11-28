// ignore_for_file: prefer_const_constructors_in_immutables, use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// ignore: must_be_immutable
class ConnectedBody extends StatelessWidget {
  InAppWebViewController? webViewController;
  final PullToRefreshController? refreshController;
  final String initialUrl;

  ConnectedBody({
    Key? key,
    required this.webViewController,
    required this.refreshController,
    required this.initialUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: InAppWebView(
            onLoadStop: (controller, url) {
              refreshController!.endRefreshing();
            },
            onLoadError: (controller, url, code, message) {
              // Handle load errors if needed
            },
            pullToRefreshController: refreshController,
            onWebViewCreated: (controller) {
              // You can assign the controller to the provided webViewController here
              webViewController = controller;
            },
            initialUrlRequest: URLRequest(
              url: WebUri(Uri.parse(initialUrl).toString()),
            ),
          ),
        ),
      ],
    );
  }
}
