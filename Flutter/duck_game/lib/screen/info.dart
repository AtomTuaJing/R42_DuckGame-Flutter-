import 'package:duck_game/game/duck_game.dart';
import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  Info({super.key, required this.duckgame});

  final DuckGame duckgame;
  String? image;
  String? type;

  @override
  Widget build(BuildContext context) {
    switch(duckgame.duck.id) {
      case 0:
        image = "assets/images/DULSE.jpg";
        type = "Dulse";
        break;
      case 1:
        image = "assets/images/WAKAME.jpg";
        type = "Wakame";
        break;
      case 2:
        image = "assets/images/SEA_LETTUCE.jpg";
        type = "Sea Lettuce";
        break;
      case 3:
        image = "assets/images/NORI.jpg";
        type = "Nori";
        break;
      case 4:
        image = "assets/images/KELP.jpg";
        type = "Kelp";
        break;
    }

    Future.delayed(Duration(seconds: 1), () {
      duckgame.resumeEngine();
      duckgame.overlays.remove("Info");
    });

    return Material(
      color: Colors.black38,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image!, width: 500),
            Text(type!, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white))
          ],
        ),
      ),
    );
  }
}