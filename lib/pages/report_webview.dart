import 'package:bayer/contants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
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
          "Report Form",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        backgroundColor: kDarkBlue,
        elevation: 0.0,
      ),
      body: Stack(children: [
        WebView(
          initialUrl: "https://bayer.harshitarora.in/report-form/",
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