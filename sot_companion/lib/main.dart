import 'package:dart_discord_rpc/dart_discord_rpc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:sot_companion/class/module.dart';
import 'package:sot_companion/helper/WebviewManager.dart';
import 'package:sot_companion/helper/WindowManager.dart';
import 'package:sot_companion/modules/discord_rpc/class/sot_activity.dart';
import 'package:webview_windows/webview_windows.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DiscordRPC.initialize();
  // Must add this line.
  await Window.initialize();
  await windowManager.ensureInitialized();
  await SOT_WebviewManager.init();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(100, 50),
    minimumSize: Size(10, 10),
    center: true,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await Window.setEffect(
      effect: WindowEffect.aero,
      dark: false,
    );
    await windowManager.show();
    await windowManager.setAlwaysOnTop(true);

    //await windowManager.setAlwaysOnTop(true);
  });

  MyApp.windowManager = windowManager;
  runApp(MyApp());
}

class MyApp extends StatelessWidget with WindowListener {
  MyApp({Key? key}) : super(key: key);
  static late WindowManager windowManager;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin, WindowListener {
  String status = "MINIMIZE";
  Module? moduleSelected;
  late TabController _tabController;

  @override
  void onWindowFocus() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _tabController =
        TabController(vsync: this, length: Module.moduleList.length);
  }

  Widget build(BuildContext context) {
    if (moduleSelected == null) {
      SOT_WindowsManager.changeSize(const Size(400, 100));
    }
    late Widget scaffoldChild;
    if (status == "MODULES") {
      scaffoldChild = _buildModules();
    } else {
      scaffoldChild = _buildMinimize();
    }
    return Scaffold(backgroundColor: Colors.transparent, body: scaffoldChild);
  }

  Widget _buildModules() {
    return _buildAllModulesColumn();
  }

  Widget _buildWebView() {
    return Expanded(child: Webview(SOT_WebviewManager.currentController));
  }

  Widget _buildAllModulesColumn() {
    return Container(
        child: DefaultTabController(
            length: 3,
            child: Column(children: [
              Row(children: [
                InkWell(
                  child: Icon(Icons.arrow_right),
                  onTap: () {
                    status = "MINIMIZE";
                    setState(() {});
                  },
                ),
                Expanded(
                    child: TabBar(
                        onTap: (int index) {
                          WindowManager.instance
                              .setSize(Module.moduleList[index].size);
                        },
                        controller: _tabController,
                        tabs: List.generate(Module.moduleList.length, (index) {
                          return Tab(
                              child:
                                  _buildModuleIcon(Module.moduleList[index]));
                        })))
              ]),
              Expanded(
                  child: TabBarView(
                      controller: _tabController,
                      children:
                          List.generate(Module.moduleList.length, (index) {
                        return Module.moduleList[index].mainPage;
                      })))
            ])));
  }

  Widget _buildModulePage() {
    return moduleSelected != null
        ? Container(
            child: Expanded(
                child: Column(children: [
            SizedBox(
              height: 4,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                height: 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white),
            SizedBox(
              height: 4,
            ),
            Expanded(child: moduleSelected!.mainPage)
          ])))
        : Container();
  }

  Widget _buildMinimize() {
    print("BUILD_MINIMZE");
    moduleSelected = null;
    SOT_WindowsManager.changeSize(Size(100, 50));
    return Row(children: [
      InkWell(
        child: Icon(Icons.close),
        onTap: () {
          windowManager.close();
        },
      ),
      Expanded(
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        InkWell(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: NetworkImage(
                  "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/b/b8/Investigator_of_Dark_Intrigue_emblem.png/revision/latest/scale-to-width-down/1000?cb=20220630155533"),
            ),
            onTap: () {
              _tabController.animateTo(0);
              status = "MODULES";
              setState(() {});
            }),
      ]))
    ]);
  }

  Widget _buildModuleIcon(Module module) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      backgroundImage: NetworkImage(module.image),
    );
  }
}
