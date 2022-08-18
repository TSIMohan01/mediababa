import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Media Baba',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WebBaba(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WebBaba extends StatelessWidget {
  const WebBaba({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: "https://www.google.com/",
      ),
    );
  }
}
