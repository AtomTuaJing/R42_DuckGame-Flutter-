import 'package:duck_game/game/duck_game.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key, required this.duckgame});

  final DuckGame duckgame;
  static const id = "MainMenu";

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    widget.duckgame.pauseEngine();

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          widget.duckgame.duck.score = 0;
          widget.duckgame.isRestart = false;
          widget.duckgame.overlays.remove("MainMenu");
          widget.duckgame.resumeEngine();
        },
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset("assets/images/logo.png"),
        ),
      ),
    );
  }
}
