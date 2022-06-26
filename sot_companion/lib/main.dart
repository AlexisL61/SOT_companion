import 'package:flutter/material.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart';
import 'package:sot_companion/class/food.dart';
import 'package:sot_companion/helper/WindowManager.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Must add this line.
  await Window.initialize();
  await windowManager.ensureInitialized();

  WindowOptions windowOptions = const WindowOptions(
    size: Size(250, 50),
    minimumSize: Size(10,10),
    center: true,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.setBounds(Rect.largest);
    Size size = await windowManager.getSize();
    print(size);
    await windowManager.setSize(Size(250, 50));
    await windowManager.setPosition(Offset(size.width - 280, 10));
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
  String status = "SELECT_FOOD";
  int cookingStartTime = 0;
  Food? foodToCook;
  Widget body = Container();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    switch (status) {
      case "SELECT_FOOD":
        body = _buildSelectFood();
        break;
      case "CLOSE":
        body = _buildClose();
        break;
      case "COOKING":
        body = _buildCooking();
        break;
      default:
    }

    return Scaffold(backgroundColor: Colors.transparent, body: body);
  }

  Widget _buildSelectFood() {
    SOT_WindowsManager.changeSize(Size(250, 50));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Icon(Icons.arrow_right),
          onTap: () {
            status = "CLOSE";
            setState(() {});
          },
        ),
        Expanded(
            child: Row(
                children: List.generate(Food.availableFoods.length,
                    (index) => _buildFoodToCook(Food.availableFoods[index]))))
      ],
    );
  }

  Widget _buildClose() {
    SOT_WindowsManager.changeSize(Size(50, 50));
    return 
    Row(children: [
      InkWell(
        child: Icon(Icons.close),
        onTap: () {
          windowManager.close();
        },
      ),
    Expanded(child:Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      
      InkWell(
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/c/c6/Food.png/revision/latest/scale-to-width-down/1000?cb=20200116140939"),
          ),
          onTap: () {
            status = "SELECT_FOOD";
            setState(() {});
          }),
    ]))]);
  }

  Widget _buildCooking() {
    SOT_WindowsManager.changeSize(Size(250, 50));
    print(double.maxFinite);
    return Container(
        padding: EdgeInsets.only(right: 10),
        child: TweenAnimationBuilder<double>(
            tween: Tween<double>(
                begin: (DateTime.now().millisecondsSinceEpoch / 1000) -
                    cookingStartTime / 1000,
                end: (foodToCook!.timeToBurn).toDouble()),
            duration: Duration(
                seconds: (foodToCook!.timeToBurn -
                        ((DateTime.now().millisecondsSinceEpoch / 1000) -
                            cookingStartTime / 1000))
                    .toInt()),
            builder: (BuildContext context, double time, Widget? child) {
              return Row(children: [
                InkWell(
                  child: Icon(Icons.arrow_right),
                  onTap: () {
                    status = "SELECT_FOOD";
                    setState(() {});
                  },
                ),
                SizedBox(
                  width: 10,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(foodToCook!.image),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                        time < foodToCook!.timeToCook
                            ? (foodToCook!.timeToCook - time.floor())
                                    .toString() +
                                "s"
                            : (foodToCook!.timeToBurn - time.floor())
                                    .toString() +
                                "s",
                        style: TextStyle(
                            color: time < foodToCook!.timeToBurn
                                ? (time < foodToCook!.timeToCook
                                    ? Colors.white
                                    : Colors.green)
                                : Colors.red,
                            fontSize: 20)),
                    Stack(
                      children: [
                        Container(
                          height: 5,
                          width: double.maxFinite,
                          color: Colors.white,
                        ),
                        LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Container(
                            height: 5,
                            width: time > foodToCook!.timeToCook
                                ? constraints.maxWidth
                                : time *
                                    constraints.maxWidth /
                                    foodToCook!.timeToCook,
                            color: Colors.green,
                          );
                        }),
                        LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          return Container(
                            height: 5,
                            width: time > foodToCook!.timeToCook
                                ? (time > foodToCook!.timeToBurn
                                    ? constraints.maxWidth
                                    : (time - foodToCook!.timeToCook) *
                                        constraints.maxWidth /
                                        (foodToCook!.timeToBurn -
                                            foodToCook!.timeToCook))
                                : 0,
                            color: Colors.red,
                          );
                        }),
                        //Container(height:5, width:double.maxFinite,color: Colors.red,),
                      ],
                    )
                  ],
                ))
              ]);
            }));
  }

  Widget _buildFoodToCook(Food food) {
    return Expanded(
        child: InkWell(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(food.image),
      ),
      onTap: () {
        foodToCook = food;
        cookingStartTime = DateTime.now().millisecondsSinceEpoch;
        //print(foodToCook!.timeToCook);
        status = "COOKING";
        setState(() {});
      },
    ));
  }
}
