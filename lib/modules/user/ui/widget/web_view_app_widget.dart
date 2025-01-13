import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewAppWidget extends StatefulWidget {
  final String? title;
  final String url;
  const WebViewAppWidget({super.key, this.title, required this.url});

  @override
  State<WebViewAppWidget> createState() => _WebViewAppWidgetState();
}

class _WebViewAppWidgetState extends State<WebViewAppWidget> {
  late WebViewController _webViewController;

  @override
  void initState() {
    _webViewController = WebViewController();
    _webViewController.loadRequest(Uri.parse(widget.url));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: WebViewWidget(controller: _webViewController),
    );
  }
}
