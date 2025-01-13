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
  bool _isLoading = true; // Controle para exibir o loading

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true; // Exibe o loading ao iniciar o carregamento
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading =
                  false; // Oculta o loading ao finalizar o carregamento
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title ?? '')),
      body: Stack(
        children: [
          WebViewWidget(controller: _webViewController),
          if (_isLoading)
            Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
