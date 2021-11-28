import 'package:bayer/contants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductInformation extends StatefulWidget {
  final String? productLink;
  const ProductInformation({Key? key, @required this.productLink})
      : super(key: key);

  @override
  _ProductInformationState createState() => _ProductInformationState();
}

class _ProductInformationState extends State<ProductInformation> {
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
          "Information",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: kDarkBlue,
        elevation: 0.0,
      ),
      body: Stack(children: [
        WebView(
          initialUrl: widget.productLink,
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
//TODO: Handle exceptions like if the url not exists, url other then our own company url etc