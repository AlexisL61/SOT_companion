import 'package:flutter/widgets.dart';
import 'package:sot_companion/modules/cook_time/pages/food_page.dart';
import 'package:sot_companion/modules/discord_rpc/pages/rpc.dart';

class Module {
  String name;
  String image;
  Widget mainPage;

  Module(this.name, this.image, this.mainPage);

  static List<Module> moduleList = [
    Module(
        "Cuisine",
        "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/c/c6/Food.png/revision/latest/scale-to-width-down/1000?cb=20200116140939",
        CookTime_Page()),
    Module(
        "Discord_rpc",
        "https://discord.com/assets/9f6f9cd156ce35e2d94c0e62e3eff462.png",
        RPC_Page()),
  ];
}
