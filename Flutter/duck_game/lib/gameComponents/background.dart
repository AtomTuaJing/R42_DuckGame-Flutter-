import 'package:duck_game/game/assets.dart';
import 'package:duck_game/game/duck_game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';

class Background extends SpriteComponent with HasGameRef<DuckGame> {
  Background();

  @override
  void onLoad() async {
    final background = await Flame.images.load(Assets.background);
    size = Vector2(1980, 1080);
    sprite = Sprite(background);
  }
}