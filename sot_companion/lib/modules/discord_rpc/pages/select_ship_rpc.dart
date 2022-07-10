import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sot_companion/modules/discord_rpc/class/sot_activity.dart';
import 'package:sot_companion/modules/discord_rpc/enums/sot_rpc.dart';

class SelectShipRPC_Page extends StatefulWidget {
  SelectShipRPC_Page({Key? key}) : super(key: key);

  @override
  State<SelectShipRPC_Page> createState() => _SelectShipRPC_PageState();
}

class _SelectShipRPC_PageState extends State<SelectShipRPC_Page> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
            color: Colors.blue.withOpacity(0.8),
            child: Column(
                children: List.generate(SOTRPC_Ship.values.length,
                    (index) => _buildShipWidget(SOTRPC_Ship.values[index])))));
  }

  Widget _buildShipWidget(SOTRPC_Ship ship) {
    return ListTile(
      title: Text(ship.name, style: TextStyle(color: Colors.white)),
      subtitle: Text("${ship.maxCrewSize} players",
          style: TextStyle(color: Colors.white)),
      leading: CircleAvatar(backgroundImage: NetworkImage(ship.image)),
      onTap: () async {
        await showModalBottomSheet<void>(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) =>
              SelectShipCrewSize_Page(ship: ship),
        );

        Navigator.of(context).pop(ship);
      },
    );
  }
}

class SelectShipCrewSize_Page extends StatefulWidget {
  SelectShipCrewSize_Page({Key? key, required this.ship}) : super(key: key);
  SOTRPC_Ship ship;
  @override
  State<SelectShipCrewSize_Page> createState() =>
      _SelectShipCrewSize_PageState();
}

class _SelectShipCrewSize_PageState extends State<SelectShipCrewSize_Page> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        heightFactor: 0.8,
        child: Container(
            color: Colors.blue.withOpacity(0.8),
            child: ListView(
                children: List.generate(widget.ship.maxCrewSize,
                    (index) => _buildCrewSizeWidget(index + 1)))));
  }

  Widget _buildCrewSizeWidget(int num) {
    return ListTile(
        title: Text("$num pirates", style: TextStyle(color: Colors.white)),
        subtitle: Text("You are $num pirates on the ship",
            style: TextStyle(color: Colors.white)),
        onTap: () {
          SOTRPC.currentActivity.crewSize = num;
          Navigator.of(context).pop();
        });
  }
}
