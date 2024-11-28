// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class CheckInternet extends StatefulWidget {
  const CheckInternet({super.key});

  @override
  State<CheckInternet> createState() => _CheckInternetState();
}

class _CheckInternetState extends State<CheckInternet> {
  InAppWebViewController? webViewController;
  PullToRefreshController? refreshController;
  var initialUrl = "https://elaborate-jelly-174952.netlify.app/";
  // ignore: prefer_typing_uninitialized_variables
  late var url;
  double progress = 0;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    checkConnectivity();
    refreshController = PullToRefreshController(
      onRefresh: () {
        webViewController!.reload();
      },
      options: PullToRefreshOptions(
        color: Colors.blue,
        backgroundColor: Colors.black,
      ),
    );
  }

  void checkConnectivity() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      isConnected = (result != ConnectivityResult.none);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: isConnected
            ? Column(
                children: [
                  Expanded(
                    child: InAppWebView(
                      onLoadStop: (controller, url) {
                        refreshController!.endRefreshing();
                      },
                      pullToRefreshController: refreshController,
                      onWebViewCreated: (controller) {
                        webViewController = controller;
                      },
                      initialUrlRequest: URLRequest(
                        url: WebUri(Uri.parse(initialUrl).toString()),
                      ),
                    ),
                  ),
                ],
              )
            : const Center(child: Text('No Internet Connection')),
      ),
    );
  }
}
