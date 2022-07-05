import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sot_companion/helper/WebviewManager.dart';
import 'package:webview_windows/webview_windows.dart';

import '../../../helper/WindowManager.dart';

class Map_Page extends StatefulWidget {
  Map_Page({Key? key}) : super(key: key);

  @override
  State<Map_Page> createState() => _Map_PageState();
}

class _Map_PageState extends State<Map_Page> {
  final _controller = WebviewController();
  bool ready = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (mounted) {
        initPlatformState();
      }
    });
  }

  Future<void> initPlatformState() async {
    // Optionally initialize the webview environment using
    // a custom user data directory
    // and/or a custom browser executable directory
    // and/or custom chromium command line flags
    //await WebviewController.initializeEnvironment(
    //    additionalArguments: '--show-fps-counter');

    try {
      await SOT_WebviewManager.currentController.initialize();

      await SOT_WebviewManager.currentController
          .setBackgroundColor(Colors.transparent);
      await SOT_WebviewManager.currentController
          .setPopupWindowPolicy(WebviewPopupWindowPolicy.allow);
      await SOT_WebviewManager.currentController
          .loadUrl('https://maps.seaofthieves.rarethief.com/');

      await SOT_WebviewManager.currentController.executeScript(
          "window.addEventListener('load', (event) => {document.body.style.width='100vw';document.body.style.height='100vh';document.body.style.overflow='hidden'});");
      //await _controller.stop();
      setState(() {
        ready = true;
      });
    } on PlatformException catch (e) {
      print(e.toString());
    }
  }

  Future<WebviewPermissionDecision> _onPermissionRequested(
      String url, WebviewPermissionKind kind, bool isUserInitiated) async {
    final decision = await showDialog<WebviewPermissionDecision>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('WebView permission requested'),
        content: Text('WebView has requested permission \'$kind\''),
        actions: <Widget>[
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.deny),
            child: const Text('Deny'),
          ),
          TextButton(
            onPressed: () =>
                Navigator.pop(context, WebviewPermissionDecision.allow),
            child: const Text('Allow'),
          ),
        ],
      ),
    );

    return decision ?? WebviewPermissionDecision.none;
  }

  @override
  Widget build(BuildContext context) {
    //SOT_WindowsManager.changeSize(const Size(400, 600));

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Expanded(child: Container()),
        InkWell(child: 
          CircleAvatar(backgroundImage: NetworkImage("https://cdn.discordapp.com/attachments/839604520245264404/993969738726260836/rare_thief.png")),
        onTap: ()async {
          await SOT_WebviewManager.currentController
          .loadUrl('https://maps.seaofthieves.rarethief.com/');
        },
        ),
        Expanded(child: Container()),
        InkWell(child: 
          CircleAvatar(backgroundImage: NetworkImage("https://cdn.discordapp.com/attachments/839604520245264404/993974389940965468/merfolks_lullaby.png")),
        onTap: ()async {
          await SOT_WebviewManager.currentController
          .loadUrl('https://www.merfolkslullaby.com/map?tab=weather');
        },
        ),
        Expanded(child: Container())
      ]),
       ready
        ? Expanded(
            child: Stack(
            children: [Webview(SOT_WebviewManager.currentController)],
          ))
        : Container()]);
  }
}
