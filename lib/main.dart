import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

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
  InAppWebViewController? _controller;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  // final Completer<InAppWebViewController> _controllerCompleter =
  //     Completer<InAppWebViewController>();

  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    // if (Platform.isAndroid) InAppWebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _goBack(context),
      child: Scaffold(
        body: SafeArea(
          child: InAppWebView(
            initialUrlRequest:
                URLRequest(url: Uri.parse("https://dev01.ml/olaris/app")),
            initialOptions: options,
            onWebViewCreated: (InAppWebViewController webViewController) {
              _controller = webViewController;

              // _controllerCompleter.future.then((value) => _controller = value);
              // _controllerCompleter.complete(webViewController);
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _goBack(BuildContext context) async {
    print(_controller);
    _controller?.goBack();
    return false;
    // if (_controller?.canGoBack()) {
    //   _controller.goBack();
    //   return Future.value(false);
    // } else {
    //   SystemNavigator.pop();
    //   return Future.value(true);
    // }
  }
}
