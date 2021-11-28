import 'package:bayer/contants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ArticleView extends StatefulWidget {
  final String? postUrl;
  const ArticleView({Key? key, @required this.postUrl}) : super(key: key);

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  WebViewController? _controller;
  bool _loading = true;
  @override
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "News",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: kDarkBlue,
        elevation: 0.0,
      ),
      body: Stack(children: [
        WebView(
          initialUrl: widget.postUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onPageFinished: (finished) {
            setState(() {
              _loading = false;
            });
          },
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
        ),
        _loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: kDarkBlue,
                ),
              )
            : Stack(),
      ]),
    );
  }
}
