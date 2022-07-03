import 'package:dart_discord_rpc/dart_discord_rpc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:sot_companion/class/module.dart';
import 'package:sot_companion/helper/WindowManager.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DiscordRPC.initialize();
  // Must add this line.
  await Window.initialize();
  await windowManager.ensureInitialized();

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

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  static late WindowManager windowManager;
  // This widget is the root of your application.
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

class _MyHomePageState extends State<MyHomePage> {
  String status = "MINIMIZE";
  Module? moduleSelected;

  Widget build(BuildContext context) {
    late Widget scaffoldChild;
    if (status == "MODULES") {
      scaffoldChild = _buildModules();
    } else {
      scaffoldChild = _buildMinimize();
    }
    return Scaffold(backgroundColor: Colors.transparent, body: scaffoldChild);
  }

  Widget _buildModules() {
    if (moduleSelected == null) {
      SOT_WindowsManager.changeSize(Size(250, 50));
    }
    return Column(children: [
      Row(children: [
        InkWell(
          child: Icon(Icons.arrow_right),
          onTap: () {
            setState(() {
              status = "MINIMIZE";
            });
          },
        ),
        Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(Module.moduleList.length, (index) {
                  return Expanded(child:Row(mainAxisAlignment: MainAxisAlignment.center, children: [ _buildModuleIcon(Module.moduleList[index])]));
                })))
      ]),
      moduleSelected != null
          ? Expanded(
              child: Column(children: [
                SizedBox(height: 4,),
              Container(
                margin: EdgeInsets.symmetric(horizontal:10),
                  height: 2,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white),
                  SizedBox(height: 4,),
              Expanded(child: moduleSelected!.mainPage)
            ]))
          : Container()
    ]);
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
              status = "MODULES";
              setState(() {});
            }),
      ]))
    ]);
  }

  Widget _buildModuleIcon(Module module) {
    return InkWell(
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(module.image),
        ),
        onTap: () {
          if (moduleSelected == null || moduleSelected!.name != module.name) {
            moduleSelected = module;
            setState(() {});
          }
        });
  }
}
