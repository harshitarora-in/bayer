import 'package:bayer/contants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
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
          initialUrl: "https://www.bayer.com/en/products/products-from-A-to-Z",
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
