import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class FbWebView extends StatefulWidget {
  final String selectedUrl;

  FbWebView({this.selectedUrl});

  @override
  _FbWebViewState createState() => _FbWebViewState();
}

class _FbWebViewState extends State<FbWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();

    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      if (url.contains("#access_token")) {
        succeed(url);
      }

      if (url.contains(
          "https://www.facebook.com/connect/login_success.html?error=access_denied&error_code=200&error_description=Permissions+error&error_reason=user_denied")) {
        denied();
      }
    });
  }

  denied() {
    Navigator.pop(context);
  }

  succeed(String url) {
    var params = url.split("access_token=");

    var endparam = params[1].split("&");

    Navigator.pop(context, endparam[0]);
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      url: widget.selectedUrl,
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Color.fromRGBO(66, 103, 178, 1),
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          "Facebook login",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
