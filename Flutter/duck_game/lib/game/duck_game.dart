import 'package:duck_game/gameComponents/algae.dart';
import 'package:duck_game/gameComponents/background.dart';
import 'package:duck_game/gameComponents/duck.dart';
import 'package:duck_game/gameComponents/land.dart';
import 'package:duck_game/gameComponents/trash.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class DuckGame extends FlameGame with HasCollisionDetection {
  late Duck duck;
  late TextComponent score;
  bool isRestart = false;
  Timer interval = Timer(3, repeat: true);

  @override
  Future<void> onLoad() async {
    addAll([
      Background(),
      Land(),
      duck = Duck(),
      score = buildScore()
    ]);

    interval.onTick = () {
      addAll([
        Algae(),
        Trash()
      ]);
    };
  }

  TextComponent buildScore() {
    return TextComponent(
        text: "Score: 0",
        position: Vector2(170, size.y - 50),
        anchor: Anchor.center,
        textRenderer: TextPaint(
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 60,
                fontFamily: "Game")));
  }
  
  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);

    score.text = "Score: ${4 - duck.score} / 4";
  }
}