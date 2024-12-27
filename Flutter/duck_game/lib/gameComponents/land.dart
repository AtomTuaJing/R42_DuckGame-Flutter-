import 'package:duck_game/game/assets.dart';
import 'package:duck_game/game/config.dart';
import 'package:duck_game/game/duck_game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/parallax.dart';

class Land extends ParallaxComponent<DuckGame> with HasGameRef<DuckGame> {
  Land();

  @override
  Future<void> onLoad() async {
    final land = await Flame.images.load(Assets.land);
    position = Vector2(0, 0);
    parallax = Parallax([
      ParallaxLayer(
        ParallaxImage(land, fill: LayerFill.none),
        velocityMultiplier: Vector2(-1, 0)
      ),
    ]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    parallax?.baseVelocity.x = Config.gameSpeed;
  }
}