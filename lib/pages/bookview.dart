import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Bookview extends StatefulWidget {
  const Bookview({super.key});

  @override
  State<Bookview> createState() => _BookviewState();
}

class _BookviewState extends State<Bookview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Penetration Testing for Beginner A Hands-On Introduction to Hacking"),
      ),
      body: WebView(
        initialUrl:
            "https://www.booksfree.org/penetration-testing-by-georgia-weidman-pdf-free-download/",
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
