import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
// 1. Import 'effects.dart' ของ Flame
// 2. Import 'animation.dart' ของ Flutter เพื่อใช้ Curves

import 'package:envigame/game/howto_game.dart';

abstract class BaseBin extends SpriteComponent
    with HasGameReference<HowToGame>, CollisionCallbacks {
  final Vector2 initialPosition;

  // 2. สร้าง abstract getter สำหรับ path ของรูปภาพ
  // คลาสลูก "ต้อง" implement ส่วนนี้
  String get spritePath;

  BaseBin({required this.initialPosition});

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load(spritePath);
    // Logic ที่ใช้ร่วมกันทั้งหมดจะอยู่ที่นี่
    size = Vector2.all(200);
    anchor = Anchor.bottomCenter;
    position = initialPosition;
    add(RectangleHitbox());
  }
}
