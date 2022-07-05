import 'package:flutter/widgets.dart';
import 'package:sot_companion/modules/cook_time/pages/food_page.dart';
import 'package:sot_companion/modules/discord_rpc/pages/rpc.dart';
import 'package:sot_companion/modules/maps/pages/map.dart';

class Module {
  String name;
  String image;
  Size size;
  StatefulWidget mainPage;

  Module(this.name, this.image, this.size, this.mainPage);

  static List<Module> moduleList = [
    Module(
        "Cuisine",
        "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/c/c6/Food.png/revision/latest/scale-to-width-down/1000?cb=20200116140939",
        Size(400, 100),
        CookTime_Page()),
    Module(
        "Discord_rpc",
        "https://discord.com/assets/9f6f9cd156ce35e2d94c0e62e3eff462.png",
        Size(400, 300),
        RPC_Page()),
    Module(
        "Maps",
        "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/5/5c/Treasure_Map_Icon.png/revision/latest/scale-to-width-down/125?cb=20200923101156",
        Size(400, 600),
        Map_Page()),
  ];
}
