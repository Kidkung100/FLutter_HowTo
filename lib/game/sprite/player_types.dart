import 'package:flame/components.dart';
import 'player.dart';
import 'package:envigame/game/sprite/all_bin.dart';

// --- ประเภทสีแดง ---
abstract class RedTypePlayer extends Player {
  RedTypePlayer({required super.fallSpeed, required super.initialPosition});

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (isBeingRemoved) return;
    if (other is RedBin) {
      isBeingRemoved = true;
      game.increaseScore();
      removeFromParent();
    }
  }
}

// --- ประเภทสีขาว ---
abstract class WhiteTypePlayer extends Player {
  WhiteTypePlayer({required super.fallSpeed, required super.initialPosition});

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (isBeingRemoved) return;
    if (other is WhiteBin) {
      isBeingRemoved = true;
      game.increaseScore();
      removeFromParent();
    }
  }
}

// --- ประเภทสีดำ ---
abstract class BlackTypePlayer extends Player {
  BlackTypePlayer({required super.fallSpeed, required super.initialPosition});

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (isBeingRemoved) return;
    if (other is BlackBin) {
      isBeingRemoved = true;
      game.increaseScore();
      removeFromParent();
    }
  }
}

// --- ประเภทสีน้ำเงิน ---
abstract class BlueTypePlayer extends Player {
  BlueTypePlayer({required super.fallSpeed, required super.initialPosition});

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (isBeingRemoved) return;
    if (other is BlueBin) {
      isBeingRemoved = true;
      game.increaseScore();
      removeFromParent();
    }
  }
}
