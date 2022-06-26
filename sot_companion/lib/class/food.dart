class Food {
  String image;
  int timeToCook;
  int timeToBurn;

  static List<Food> availableFoods = [
    Food(
        image:
            "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/2/2c/Fish_Ruby_SplashTail.png/revision/latest/scale-to-width-down/96?cb=20200208200643",
        timeToCook: 40,
        timeToBurn: 80),
    Food(
        image:
            "https://static.wikia.nocookie.net/seaofthieves_gamepedia/images/2/2c/Fish_Ruby_SplashTail.png/revision/latest/scale-to-width-down/96?cb=20200208200643",
        timeToCook: 90,
        timeToBurn: 180),
    Food(
        image:
            "https://cdn.discordapp.com/attachments/839604520245264404/990301029503488060/unknown.png",
        timeToCook: 60,
        timeToBurn: 120),
    Food(
        image:
            "https://cdn.discordapp.com/attachments/839604520245264404/990302676828975134/unknown.png",
        timeToCook: 120,
        timeToBurn: 240)
  ];

  Food(
      {required this.image,
      required this.timeToCook,
      required this.timeToBurn});
}
