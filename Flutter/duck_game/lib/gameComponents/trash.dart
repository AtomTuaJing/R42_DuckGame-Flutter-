import 'dart:math';
import 'package:duck_game/game/assets.dart';
import 'package:duck_game/game/duck_game.dart';
import 'package:duck_game/gameComponents/duck.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Trash extends SpriteComponent with HasGameRef<DuckGame>, CollisionCallbacks {
  Trash();

  final random = Random();

  @override
  Future<void> onLoad() async {
    final trash1 = await Flame.images.load(Assets.trash1);
    final trash2 = await Flame.images.load(Assets.trash2);
    final trash3 = await Flame.images.load(Assets.trash3);
    final trash4 = await Flame.images.load(Assets.trash4);
    size = Vector2(120, 120);
    position = Vector2(-size.x, random.nextDouble() * gameRef.size.y + 230);

    int number = random.nextInt(4);

    switch(number) {
      case 0:
        sprite = Sprite(trash1);
        break;
      case 1:
        sprite = Sprite(trash2);
        break;
      case 2:
        sprite = Sprite(trash3);
        break;
      case 3:
        sprite = Sprite(trash4);
        break;
    }

    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (position.x > gameRef.size.x) {
      removeFromParent();
    }

    if (gameRef.isRestart) {
      removeFromParent();
      gameRef.isRestart = false;
    }

    position.x += 220 * dt;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Duck) {
      removeFromParent();
      gameRef.pauseEngine();
      gameRef.isRestart = true;
      gameRef.overlays.add("MainMenu");
    }
  }
}