import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaystackWebView extends StatefulWidget {
  final String url;

  const PaystackWebView({
    super.key,
    required this.url,
  });

  @override
  State<PaystackWebView> createState() => _PaystackWebViewState();
}

class _PaystackWebViewState extends State<PaystackWebView> {
  late final WebViewController _controller;
  bool _hasClosed = false;

  void _close(bool success) {
    if (_hasClosed) return;
    _hasClosed = true;
    Navigator.pop(context, success);
  }

  bool _isCletechCallback(String url) {
    return url.startsWith("https://www.cletechbundles.com");
  }

  @override
  void initState() {
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onUrlChange: (change) {
            final url = change.url ?? "";
            if (_isCletechCallback(url)) {
              _close(false);
            }
          },
          onNavigationRequest: (request) {
            final url = request.url;
            if (_isCletechCallback(url)) {
              _close(false);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Secure Payment"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => _close(false),
        ),
      ),
      body: WebViewWidget(controller: _controller),
    );
  }
}
