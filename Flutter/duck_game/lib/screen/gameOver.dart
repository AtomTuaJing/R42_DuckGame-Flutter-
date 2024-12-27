import 'package:duck_game/game/duck_game.dart';
import 'package:flutter/material.dart';

class GameOver extends StatelessWidget {
  const GameOver({super.key, required this.duckgame});

  final DuckGame duckgame;
  static const id = "GameOver";

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black38,
      child: Center(
        child: ElevatedButton(onPressed: () async {
          duckgame.overlays.remove("GameOver");
          duckgame.duck.score = 0;
          duckgame.resumeEngine();
        }, child: Text("Restart", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),)),
      ),
    );
  }
}