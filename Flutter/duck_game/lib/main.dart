import 'package:duck_game/game/duck_game.dart';
import 'package:duck_game/screen/gameOver.dart';
import 'package:duck_game/screen/info.dart';
import 'package:duck_game/screen/mainMenu.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions = WindowOptions(
    size: Size(1280, 720),
    center: true,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  final game = DuckGame();

  runApp(GameWidget(game: game, initialActiveOverlays: [
    MainMenu.id
  ], overlayBuilderMap: {
    "MainMenu": (context, _) => MainMenu(duckgame: game),
    "GameOver": (context, _) => GameOver(duckgame: game),
    "Info": (context, _) => Info(duckgame: game),
  }));
}
