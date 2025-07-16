import 'dart:async';
import 'dart:math';

import 'package:envigame/game/howto_game.dart';
import 'package:envigame/game/sprite/player.dart';
import 'package:envigame/game/sprite/all_bin.dart';
import 'package:envigame/game/sprite/specific_player.dart';
import 'package:flame/components.dart';

class HowToWorld extends World
    with HasGameReference<HowToGame>, HasCollisionDetection {
  final _random = Random();
  static const int binCount = 4;

  @override
  FutureOr<void> onLoad() {
    super.onLoad();

    // --- ส่วนของการสร้าง Bin (เหมือนเดิม) ---
    final segmentWidth = game.size.x / binCount;
    final yPos = game.size.y / 2;
    final List<Component> bins = [];
    for (int i = 0; i < binCount; i++) {
      final xPos = -game.size.x / 2 + (i * segmentWidth) + (segmentWidth / 2);
      final position = Vector2(xPos, yPos);
      switch (i) {
        case 0:
          bins.add(RedBin(initialPosition: position));
          break;
        case 1:
          bins.add(WhiteBin(initialPosition: position));
          break;
        case 2:
          bins.add(BlackBin(initialPosition: position));
          break;
        case 3:
          bins.add(BlueBin(initialPosition: position));
          break;
      }
    }
    addAll(bins);

    // ✅ 1. แก้ไข Logic การสร้าง Player ให้ทยอยปล่อย
    // เราจะสร้าง Timer 20 ตัวแทนการสร้าง Player โดยตรง
    for (int i = 0; i < 20; i++) {
      // ✅ 2. สุ่มเวลาดีเลย์สำหรับ Player แต่ละตัว (0 ถึง 30 วินาที)
      final double randomDelay = _random.nextDouble() * 30.0;

      // ✅ 3. สร้าง TimerComponent
      final timer = TimerComponent(
        period: randomDelay, // ตั้งเวลาดีเลย์
        removeOnFinish: true, // ให้ลบ Timer นี้ทิ้งเมื่อทำงานเสร็จ
        onTick: () {
          // ✅ 4. เมื่อถึงเวลา ให้สร้าง Player 1 ตัว
          //    Logic การสุ่มค่าและ switch-case จะย้ายมาอยู่ในนี้
          final double randomSpeed =
              _random.nextDouble() * 50 + 50; // ความเร็ว 50-100
          final double randomX =
              _random.nextDouble() * game.size.x - game.size.x / 2;
          final Vector2 initialPos = Vector2(
            randomX,
            -game.size.y / 2 - 150 - (_random.nextDouble() * 300),
          );

          Player player;
          switch (i) {
            case 0:
              player = Player1(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 1:
              player = Player2(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 2:
              player = Player3(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 3:
              player = Player4(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 4:
              player = Player5(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 5:
              player = Player6(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 6:
              player = Player7(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 7:
              player = Player8(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 8:
              player = Player9(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 9:
              player = Player10(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 10:
              player = Player11(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 11:
              player = Player12(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 12:
              player = Player13(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 13:
              player = Player14(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 14:
              player = Player15(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 15:
              player = Player16(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 16:
              player = Player17(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 17:
              player = Player18(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 18:
              player = Player19(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            case 19:
              player = Player20(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
              break;
            default:
              player = Player1(
                fallSpeed: randomSpeed,
                initialPosition: initialPos,
              );
          }

          // เพิ่ม Player ที่สร้างเสร็จเข้าไปใน World
          add(player);
        },
      );

      // เพิ่ม TimerComponent เข้าไปใน World (มันจะเริ่มนับเวลาทันที)
      add(timer);
    }
  }
}
