import 'dart:math';
import 'package:duck_game/game/assets.dart';
import 'package:duck_game/game/duck_game.dart';
import 'package:duck_game/gameComponents/duck.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Algae extends SpriteComponent with HasGameRef<DuckGame>, CollisionCallbacks {
  Algae();

  final random = Random();
  late int id;

  @override
  Future<void> onLoad() async {
    final dulse = await Flame.images.load(Assets.dulse);
    final wakame = await Flame.images.load(Assets.wakame);
    final seaLettuce = await Flame.images.load(Assets.seaLettuce);
    final nori = await Flame.images.load(Assets.nori);
    final kelp = await Flame.images.load(Assets.kelp);
    size = Vector2(160, 160);
    position = Vector2(-size.x, random.nextDouble() * gameRef.size.y + 230);

    int number = random.nextInt(4);
    id = number;

    switch(number) {
      case 0:
        sprite = Sprite(dulse);
        break;
      case 1:
        sprite = Sprite(wakame);
        break;
      case 2:
        sprite = Sprite(seaLettuce);
        break;
      case 3:
        sprite = Sprite(nori);
        break;
      case 4:
        sprite = Sprite(kelp);
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
      gameRef.duck.score += 1;
      gameRef.duck.id = id;
      gameRef.pauseEngine();
      gameRef.overlays.add("Info");
    }
  }
}