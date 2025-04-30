import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewHandler extends StatefulWidget {
  final String link;
  const WebviewHandler({super.key, required this.link});

  @override
  State<WebviewHandler> createState() => _WebviewHandlerState();
}

class _WebviewHandlerState extends State<WebviewHandler> {
  late WebViewController _controller;
  int loadingPercentage = 0;

  @override
  void initState() {
    super.initState();
    // Initialize WebView
    if (Platform.isAndroid) {
      WebViewPlatform.instance;
    }
    _controller =
        WebViewController()
          ..setJavaScriptMode(JavaScriptMode.unrestricted)
          ..setNavigationDelegate(
            NavigationDelegate(
              onPageStarted: (url) {
                setState(() {
                  loadingPercentage = 0;
                });
              },
              onProgress: (progress) {
                setState(() {
                  loadingPercentage = (progress).toInt();
                });
              },
              onPageFinished: (url) {
                setState(() {
                  loadingPercentage = 100;
                });
              },
            ),
          )
          ..loadRequest(Uri.parse(widget.link));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _clearWebViewData();

    super.dispose();
  }

  Future<void> _clearWebViewData() async {
    await _controller.clearCache();
    await _controller.clearLocalStorage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close, color: Colors.white),
        ),
        title: Text(
          "Crux",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          if (loadingPercentage < 100)
            LinearProgressIndicator(
              value: loadingPercentage / 100.0,
              color: Colors.blue,
              backgroundColor: Colors.grey[200],
            ),
          Expanded(child: WebViewWidget(controller: _controller)),
        ],
      ),
    );
  }
}
