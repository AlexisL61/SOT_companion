import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:sot_companion/helper/WindowManager.dart';
import 'package:sot_companion/modules/cook_time/class/food.dart';
import 'package:sot_companion/modules/cook_time/class/food_intent.dart';

class CookTime_Page extends StatefulWidget {
  CookTime_Page({Key? key}) : super(key: key);

  @override
  State<CookTime_Page> createState() => _CookTime_PageState();
}

class _CookTime_PageState extends State<CookTime_Page> {
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
        print("SELECT_FOOD");
        body = _buildSelectFood();
        break;
      case "COOKING":
        print("COOKING");
        body = _buildCooking();
        break;
      default:
    }

    return Scaffold(backgroundColor: Colors.transparent, body: body);
  }

  Widget _buildSelectFood() {
    //SOT_WindowsManager.changeSize(Size(250, 100));
    return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Row(
                        children: List.generate(
                            Food.availableFoods.length,
                            (index) =>
                                _buildFoodToCook(Food.availableFoods[index]))))
              ],
            );
  }

  Widget _buildCooking() {
    //SOT_WindowsManager.changeSize(Size(250, 100));
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
