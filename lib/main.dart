import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class WebBaba extends StatefulWidget {
  const WebBaba({Key? key}) : super(key: key);

  @override
  State<WebBaba> createState() => _WebBabaState();
}

class _WebBabaState extends State<WebBaba> {
  late WebViewController _controller;
  final Completer<WebViewController> _controllerCompleter =
      Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Scaffold(
        body: SafeArea(
          child: WebView(
            initialUrl: 'https://dev01.ml/olaris/app',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controllerCompleter.future.then((value) => _controller = value);
              _controllerCompleter.complete(webViewController);
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    if (await _controller.canGoBack()) {
      _controller.goBack();
      return Future.value(false);
    } else {
      SystemNavigator.pop();
      return Future.value(true);
    }
  }
}

// class WebBaba extends StatelessWidget {
//   const WebBaba({Key? key}) : super(key: key);

//   final Completer<WebViewController> _controllerCompleter =
//       Completer<WebViewController>();

//   WebViewController _controller;

//   Future<bool> _onWillPop(BuildContext context) async {
//     if (await _controller.canGoBack()) {
//       _controller.goBack();
//       return Future.value(false);
//     } else {
//       return Future.value(true);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () => _onWillPop(context),
//       child: Scaffold(
//         body: SafeArea(
//           child: WebView(
//             javascriptMode: JavascriptMode.unrestricted,
//             initialUrl: "https://dev01.ml/olaris/app",
//             onWebViewCreated: (WebViewController webViewController) {
//               _controllerCompleter.future.then((value) => _controller = value);
//               _controllerCompleter.complete(webViewController);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
