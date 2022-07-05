import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sot_companion/helper/WindowManager.dart';
import 'package:sot_companion/modules/discord_rpc/class/sot_activity.dart';
import 'package:sot_companion/modules/discord_rpc/enums/sot_rpc.dart';
import 'package:sot_companion/modules/discord_rpc/pages/select_activity_rpc.dart';
import 'package:sot_companion/modules/discord_rpc/pages/select_ship_rpc.dart';

class RPC_Page extends StatefulWidget {
  RPC_Page({Key? key}) : super(key: key);

  @override
  State<RPC_Page> createState() => _RPC_PageState();
}

class _RPC_PageState extends State<RPC_Page> {
  String status = "MENU";
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
      case "MENU":
        body = _buildMenu();
        break;
      case "SELECT_SHIP":
        body = SelectShipRPC_Page();
        break;
      case "SELECT_ACTIVITY":
        //body = _buildSelectActivity();
        break;
      default:
    }

    return Scaffold(backgroundColor: Colors.transparent, body: body);
  }

  Widget _buildMenu() {
    //SOT_WindowsManager.changeSize(const Size(250, 300));
    return Row(children: [
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text(
              "Bateau",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: (SOTRPC.currentActivity.ship != null)
                        ? NetworkImage(SOTRPC.currentActivity.ship!.image)
                        : null),
                onTap: () async {
                  SOTRPC_Ship? shipChoosen = await showModalBottomSheet<void>(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) => SelectShipRPC_Page(),
                  ) as SOTRPC_Ship;
                  if (shipChoosen != null) {
                    SOTRPC.currentActivity.setShip(shipChoosen);
                    setState(() {});
                  }
                }),
            SizedBox(
              height: 10,
            ),
            Text(
              SOTRPC.currentActivity.ship != null
                  ? SOTRPC.currentActivity.ship!.name
                  : "Aucun bateau",
              style: TextStyle(fontSize: 15, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ])),
      Container(
          width: 3,
          height: double.maxFinite,
          color: Colors.white.withOpacity(0.2)),
      Expanded(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            Text(
              "Aventure",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
                child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    backgroundImage: (SOTRPC.currentActivity.activity != null)
                        ? NetworkImage(SOTRPC.currentActivity.activity!.image)
                        : null),
                onTap: () async {
                  SOTRPC_Activity? activityChoosen =
                      await showModalBottomSheet<void>(
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (BuildContext context) => SelectActivityRPC_Page(),
                  ) as SOTRPC_Activity;
                  if (activityChoosen != null) {
                    SOTRPC.currentActivity.setActivity(activityChoosen);
                    setState(() {});
                  }
                }),
            SizedBox(
              height: 10,
            ),
            Text(
              SOTRPC.currentActivity.activity != null
                  ? SOTRPC.currentActivity.activity!.name
                  : "Aucune\naventure",
              style: TextStyle(fontSize: 15, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ])),
    ]);
  }
}
