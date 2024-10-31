import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';


class CustomWebView extends StatefulWidget {
  String url;
  CustomWebView(this.url, { Key? key }) : super(key: key);

  @override
  State<CustomWebView> createState() => CustomWebViewState();
}


class CustomWebViewState extends State<CustomWebView> {
  WebViewController? webController;


  @override
  void initState() {
    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: const Color(0xff18223E)));
    return Scaffold(
        body: SafeArea(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Center(
                child: WebView(
                  zoomEnabled: false,
                  initialUrl: widget.url,
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (controller){
                    webController = controller;
                    setState(() {});
                  },
                  onPageFinished: (url){
                    webController!.evaluateJavascript(
                        "function toMobile(){"
                            "var meta = document.createElement('meta'); "
                            "meta.setAttribute('name', 'viewport');"
                            " meta.setAttribute('content', 'width=device-width, initial-scale=1'); "
                            "var head= document.getElementsByTagName('head')[0];"
                            "head.appendChild(meta); "
                            "}"
                            "toMobile()"
                    );
                  },
                ),
              ),
              Positioned(
                  top: Get.height * 0.015,
                  child: Container(
                      width: Get.width*0.65,
                      alignment: Alignment.centerLeft,
                      color: Colors.transparent,
                      // color: Color(0xFF525f7f),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        icon: Icon(Icons.arrow_back,size: 20,),
                        color: Colors.black,
                        onPressed: () {
                          print('demo');
                          Get.back();
                        },
                      )))
            ],
          ),
        )

    );
  }
}