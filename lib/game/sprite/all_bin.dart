import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/animation.dart';
import 'bin.dart';
import 'package:envigame/game/sprite/player_types.dart';

// --- คลาสสำหรับถังสีแดง ---
class RedBin extends BaseBin {
  // ส่ง initialPosition กลับไปให้ constructor ของ BaseBin
  RedBin({required super.initialPosition});

  // implement getter เพื่อระบุ path รูปภาพของตัวเอง
  @override
  String get spritePath => 'BinRed.png';
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    // 3. ตรวจสอบว่าชนกับ Player "ประเภทที่ถูกต้อง" หรือไม่
    if (other is RedTypePlayer) {
      // ถ้าใช่, ถึงจะแสดงเอฟเฟกต์
      add(BounceEffect());
    }
  }
}

// --- คลาสสำหรับถังสีขาว ---
class WhiteBin extends BaseBin {
  WhiteBin({required super.initialPosition});

  @override
  String get spritePath => 'BinWhite.png';
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is WhiteTypePlayer) {
      add(BounceEffect());
    }
  }
}

// --- คลาสสำหรับถังสีดำ ---
class BlackBin extends BaseBin {
  BlackBin({required super.initialPosition});

  @override
  String get spritePath => 'BinBLack.png';
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is BlackTypePlayer) {
      add(BounceEffect());
    }
  }
}

// --- คลาสสำหรับถังสีน้ำเงิน ---
class BlueBin extends BaseBin {
  BlueBin({required super.initialPosition});

  @override
  String get spritePath => 'BinBlue.png';
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is BlueTypePlayer) {
      add(BounceEffect());
    }
  }
}

class BounceEffect extends ScaleEffect {
  BounceEffect()
    : super.by(
        Vector2.all(1.2),
        EffectController(duration: 0.1, alternate: true, curve: Curves.easeIn),
      );
}
