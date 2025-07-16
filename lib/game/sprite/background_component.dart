import 'package:flame/components.dart';
import 'package:flame/flame.dart'; // Required for Flame.images.load

class BackgroundComponent extends SpriteComponent with HasGameReference {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    // Load the background image
    final image = await Flame.images.load('background.webp');
    sprite = Sprite(image);
  }

  @override
  void onGameResize(Vector2 size) {
    // Resize the background to fit the screen
    this.size = size;
    super.onGameResize(size);
  }
}
