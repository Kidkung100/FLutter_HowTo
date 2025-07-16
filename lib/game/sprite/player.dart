import 'dart:async';

import 'package:envigame/game/howto_game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/collisions.dart';

abstract class Player extends SpriteComponent
    with HasGameReference<HowToGame>, DragCallbacks, CollisionCallbacks {
  bool _isDragged = false;
  bool isBeingRemoved = false;

  final double fallSpeed;
  final Vector2 initialPosition;
  String get spritePath;

  Player({required this.fallSpeed, required this.initialPosition});

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load(spritePath);
    size = Vector2.all(150);
    position = initialPosition;
    anchor = Anchor.center;
    add(RectangleHitbox());
  }

  @override
  void onDragStart(DragStartEvent event) {
    super.onDragStart(event);
    _isDragged = true;
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);
    position += event.canvasDelta;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    super.onDragEnd(event);
    _isDragged = false;
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (!_isDragged) {
      position.y += fallSpeed * dt;
    }

    if (position.y > game.size.y / 2 + size.y / 2) {
      removeFromParent();
    }

    final double minX = -(game.size.x / 2) + (size.x / 2);
    final double maxX = (game.size.x / 2) - (size.x / 2);

    position.x = position.x.clamp(minX, maxX);
  }

  void move(double deltaX) {
    position.x += deltaX;
  }
}
