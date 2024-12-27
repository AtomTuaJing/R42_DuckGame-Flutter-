import 'package:duck_game/game/assets.dart';
import 'package:duck_game/game/duck_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Duck extends SpriteComponent with HasGameRef<DuckGame>, DragCallbacks {
  Duck();

  int score = 0;
  int id = 0;

  @override
  Future<void> onLoad() async {
    final duck = await Flame.images.load(Assets.duck);
    size = Vector2(150, 150);
    sprite = Sprite(duck);

    add(CircleHitbox());

    final ws = WebSocketChannel.connect(Uri.parse("ws://127.0.0.1:8000/ws"));

    await ws.ready;

    ws.stream.listen((receivePosition) {
      position = Vector2(gameRef.size.x - 200, double.parse(receivePosition.toString().split("(")[1].split(")")[0]));
    });
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