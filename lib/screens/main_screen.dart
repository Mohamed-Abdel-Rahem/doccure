// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key});

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? webViewController; // Controller for the InAppWebView
  PullToRefreshController?
      refreshController; // Controller for the pull-to-refresh functionality
  var initialUrl =
      "https://doccuregy.netlify.app/"; // Initial URL for the web view
  // ignore: prefer_typing_uninitialized_variables
  late var url; // Variable to store the current URL
  double progress = 0; // Progress of the web view loading
  bool isConnected =
      true; // Flag to check if the device is connected to the internet

  @override
  void initState() {
    super.initState();
    refreshController = PullToRefreshController(
      onRefresh: () {
        webViewController!.reload(); // Reload the web view
      },
      options: PullToRefreshOptions(
        color: Colors.blue,
        backgroundColor: Colors.black,
      ),
    );

    checkConnectivity(); // Check the initial connectivity status
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        isConnected = (result !=
            ConnectivityResult.none); // Update the connectivity status
      });
    });
  }

  Future<void> checkConnectivity() async {
    var connectivityResult = await Connectivity()
        .checkConnectivity(); // Check the current connectivity status
    setState(() {
      isConnected = (connectivityResult !=
          ConnectivityResult.none); // Update the connectivity status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isConnected
          ? AppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () async {
                  if (await webViewController!.canGoBack()) {
                    webViewController!
                        .goBack(); // Go back in the web view history
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
                    webViewController!.reload(); // Reload the web view
                  },
                  icon: const Icon(Icons.refresh),
                ),
              ],
            )
          : AppBar(
              title: const Text(
                'DOCCURE',
                style: TextStyle(
                  color: Color.fromARGB(255, 51, 144, 231),
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
      body: isConnected
          ? Column(
              children: [
                Expanded(
                  child: InAppWebView(
                    onLoadStop: (controller, url) {
                      refreshController!
                          .endRefreshing(); // End the pull-to-refresh animation
                    },
                    onLoadError: (controller, url, code, message) {
                      setState(() {
                        isConnected = false; // Update the connectivity status
                      });
                    },
                    pullToRefreshController: refreshController,
                    onWebViewCreated: (controller) {
                      webViewController =
                          controller; // Assign the web view controller
                    },
                    initialUrlRequest: URLRequest(
                      url: WebUri(Uri.parse(initialUrl).toString()),
                    ),
                  ),
                ),
              ],
            )
          : const Center(
              child: Text(
                'Connection lost. Please check your internet connection.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
    );
  }
}
