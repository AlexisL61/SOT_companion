enum SOTRPC_Ship {
  SLOOP(
      "Sloop",
      2,
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/2/23/Sloop_side.png/revision/latest/scale-to-width-down/1000?cb=20180128201317",
      "sloop",
      "En sloop"),
  BRIGANTIN(
      "Brigantin",
      3,
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/a/ae/Brigantine_side.png/revision/latest/scale-to-width-down/1000?cb=20180801224652",
      "brigantine",
      "En brig"),
  GALLION(
      "Gallion",
      4,
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/8/81/Galleon_side.png/revision/latest/scale-to-width-down/1000?cb=20180129055718",
      "galleon",
      "En gallion");

  const SOTRPC_Ship(this.name, this.maxCrewSize, this.image, this.discordKey,
      this.discordText);
  final String name;
  final int maxCrewSize;
  final String image;
  final String discordKey;
  final String discordText;
}

enum SOTRPC_ActivityCategory {
  EVENT(
      "Evenement",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/8/8c/Bilge_Rats_icon.png/revision/latest/scale-to-width-down/100?cb=20210323012132",
      [
        SOTRPC_Activity.EVT_SKELETONFORT,
        SOTRPC_Activity.EVT_FORTOFFORTUNE,
        SOTRPC_Activity.EVT_GHOSTFLEET,
        SOTRPC_Activity.EVT_SKELETONFLEET,
        SOTRPC_Activity.EVT_ASHENWINDS
      ]),
  GOLD_HOARDERS(
      "Collectionneurs d'or",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/f/f1/Gold_Hoarders_icon.png/revision/latest/scale-to-width-down/100?cb=20200512034953",
      [SOTRPC_Activity.GH_TREASURES, SOTRPC_Activity.GH_VAULT]),
  SOULS(
      "Ordre des âmes",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/0/02/Order_of_Souls_icon.png/revision/latest/scale-to-width-down/100?cb=20200512154422",
      [SOTRPC_Activity.OOS_BOUNTY, SOTRPC_Activity.OOS_GHOSTSHIP]),
  MERCHANT(
      "Marchands",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/9/9c/Merchant_Alliance_icon.png/revision/latest/scale-to-width-down/100?cb=20200512032051",
      [SOTRPC_Activity.M_CONTRACT, SOTRPC_Activity.M_CARGO]),
  HUNTERS_CALL(
      "Appel du chasseurs",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/b/b1/The_Hunter%27s_Call_icon.png/revision/latest/scale-to-width-down/100?cb=20200920220917",
      [SOTRPC_Activity.HC_FISHING]),
  REAPERS(
      "Os de la faucheuse",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/6/61/Reaper%27s_Bones_icon.png/revision/latest/scale-to-width-down/100?cb=20200512033231",
      [SOTRPC_Activity.R_CHASSE]),
  ATHENA(
      "Athéna",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/c/c2/Athena%27s_Fortune_icon.png/revision/latest/scale-to-width-down/100?cb=20200512034100",
      [SOTRPC_Activity.A_VOYAGE, SOTRPC_Activity.A_VEIL]),
  OTHER(
      "Autre",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/e/e2/Icon_info.png/revision/latest?cb=20190830001723",
      [SOTRPC_Activity.O_SEAFORT, SOTRPC_Activity.O_SANCTUARY]);

  const SOTRPC_ActivityCategory(this.name, this.image, this.activities);
  final String name;
  final String image;
  final List<SOTRPC_Activity> activities;
}

enum SOTRPC_Activity {
  GH_TREASURES(
      "Carte aux trésors",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/2/25/Treasure_Map.png/revision/latest/scale-to-width-down/250?cb=20180305183105",
      "treasure_map",
      "Cherche des coffres"),
  GH_VAULT(
      "Cache",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/4/42/Gold_Hoarder_Treasure_Vaults.jpg/revision/latest/scale-to-width-down/250?cb=20200909190928",
      "vault",
      "Fait une cache"),
  OOS_BOUNTY(
      "Equipage squelette",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/2/26/Bounty_Map.png/revision/latest/scale-to-width-down/250?cb=20180222013351",
      "skeletons",
      "Se combat contre des squelettes"),
  OOS_GHOSTSHIP(
      "Bateaux fantômes",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/b/b1/Ghost_Ship.png/revision/latest/scale-to-width-down/250?cb=20220507113646",
      "ghost_ship",
      "Se combat contre des bateaux fantômes"),
  HC_FISHING(
    "Pêche",
    "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/f/ff/Fishing.jpg/revision/latest/scale-to-width-down/250?cb=20191123135243",
    "fishing",
    "Pêche des poissons",
  ),
  A_VOYAGE(
    "Voyage d'athéna",
    "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/2/21/Chest_of_Legends.png/revision/latest/scale-to-width-down/1000?cb=20210306072509",
    "athena",
    "Fait une quête d'athéna",
  ),
  A_VEIL(
    "Voile des anciens",
    "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/3/3a/Ach_Veil_Seeker.png/revision/latest/scale-to-width-down/1000?cb=20220423001931",
    "veil",
    "Complete le voile des anciens",
  ),
  M_CONTRACT(
      "Contrat de marchand",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/b/b3/Trade_Good_Ledger.png/revision/latest/scale-to-width-down/1000?cb=20190829211226",
      "merchant_contract",
      "Fait un contrat de marchand"),
  M_CARGO(
      "Cargo perdu",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/a/a0/Shipwreck_screenshot.png/revision/latest/scale-to-width-down/1000?cb=20171219140518",
      "shipwreck",
      "Recherche une cargaison perdue"),
  R_CHASSE(
      "Chasse",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/9/96/Reaper%E2%80%99s_Bones.jpg/revision/latest/scale-to-width-down/1000?cb=20200515123039",
      "reaper_bones",
      "Chasse d'autres bateaux"),
  EVT_SKELETONFORT(
      "Fort de squelettes",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/2/22/Fortress_Skull.png/revision/latest/scale-to-width-down/250?cb=20180313205902",
      "skeleton_fort",
      "Fait un fort squelette"),
  EVT_FORTOFFORTUNE(
      "Fort de fortune",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/3/38/Fof.png/revision/latest/scale-to-width-down/1000?cb=20210421142403",
      "fort_fortune",
      "Fait un fort de fortune"),
  EVT_SKELETONFLEET(
      "Flotte de bateaux squelette",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/4/46/SkeletonShipsCloud.png/revision/latest/scale-to-width-down/734?cb=20180902134642",
      "skeleton_fleet",
      "Fait une flotte de bateaux squelette"),
  EVT_GHOSTFLEET(
      "Flotte de bateaux fantomes",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/0/0f/Haunted_Shores.png/revision/latest/scale-to-width-down/250?cb=20200617175851",
      "ghost_fleet",
      "Se combat contre Flameheart"),
  EVT_ASHENWINDS(
      "Tornade cendrée",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/d/da/Ashen_Lords.jpg/revision/latest/scale-to-width-down/250?cb=20200729133813",
      "ashen_lords",
      "Se combat contre les Ashen Lords"),
  O_SEAFORT(
      "Forteresse",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/8/86/Sea_Forts.jpg/revision/latest/scale-to-width-down/250?cb=20220303173328",
      "sea_forts",
      "Attaque une forteresse marine"),
  O_SANCTUARY(
      "Sanctuaire",
      "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/6/6f/Siren_Shrines.jpg/revision/latest/scale-to-width-down/250?cb=20210926215921",
      "sanctuary",
      "Visite un sanctuaire");

  const SOTRPC_Activity(
      this.name, this.image, this.discordKey, this.discordText);
  final String name;
  final String image;
  final String discordKey;
  final String discordText;
}
