import 'dart:io';

import 'package:duck_game/game/assets.dart';
import 'package:duck_game/game/duck_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:watcher/watcher.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Duck extends SpriteComponent with HasGameRef<DuckGame>, DragCallbacks {
  Duck();

  int score = 0;
  int id = 0;

  late FileWatcher fileWatcher;

  @override
  Future<void> onLoad() async {
    final duck = await Flame.images.load(Assets.duck);
    size = Vector2(150, 150);
    sprite = Sprite(duck);

    add(CircleHitbox());

    final filePath =
        "/Users/atomtuajing/Documents/duck_game/R42_DuckGame-Flutter-/Flutter/duck_game/assets/data.txt"; // fix file path
    final file = File(filePath);

    if (await file.exists()) {
      print("file existed");
      final directory = file.parent;
      directory.watch().listen((event) async {
        print("hello");
        if (event.type == FileSystemEvent.modify && event.path == filePath) {
          try {
            final newContent = await file.readAsString();
            print(newContent);
          } catch (e) {
            print(e);
          }
        }
      });
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (position.y < 230) {
      position.y = 231;
    }

    if (position.y > gameRef.size.y - size.y) {
      position.y = gameRef.size.y - size.y;
    }

    if (score >= 4) {
      gameRef.isRestart = true;
      gameRef.pauseEngine();
      gameRef.overlays.add("MainMenu");
    }
  }
}
