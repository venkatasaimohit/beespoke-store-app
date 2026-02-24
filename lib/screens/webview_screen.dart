import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController controller;
  double progress = 0;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (p) => setState(() => progress = p / 100),
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, maxLines: 1),
        actions: [
          IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => controller.goBack()),
          IconButton(
              icon: const Icon(Icons.arrow_forward),
              onPressed: () => controller.goForward()),
          IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => controller.reload()),
        ],
      ),
      body: Column(
        children: [
          if (progress < 1)
            LinearProgressIndicator(value: progress),
          Expanded(child: WebViewWidget(controller: controller)),
        ],
      ),
    );
  }
}