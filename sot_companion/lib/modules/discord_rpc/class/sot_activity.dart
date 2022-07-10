import 'package:dart_discord_rpc/dart_discord_rpc.dart';
import 'package:sot_companion/modules/discord_rpc/enums/sot_rpc.dart';

class SOTRPC {
  SOTRPC_Ship? ship;
  int crewSize = 0;

  SOTRPC_Activity? activity;

  late DiscordRPC rpc;

  static SOTRPC currentActivity = SOTRPC();

  SOTRPC() {
    rpc = DiscordRPC(applicationId: "992744165802782741");
    rpc.start(autoRegister: true);
  }

  void setShip(SOTRPC_Ship ship) {
    currentActivity.ship = ship;
    update();
  }

  void setActivity(SOTRPC_Activity activity) {
    currentActivity.activity = activity;
    update();
  }

  void update() {
    rpc.updatePresence(DiscordPresence(
      state: activity != null ? activity!.discordText : null,
      details: ship != null ? "On a " + ship!.name + " ("+crewSize.toString()+"/"+ship!.maxCrewSize.toString()+")" : null,
      largeImageKey: activity != null ? activity!.discordKey : null,
      largeImageText: activity != null ? activity!.discordText : null,
      startTimeStamp: DateTime.now().millisecondsSinceEpoch,
      smallImageKey: ship != null ? ship!.discordKey : null,
      smallImageText: ship != null ? ship!.discordText+ " ("+crewSize.toString()+"/"+ship!.maxCrewSize.toString()+")" : null,
    ));
  }
}
