import 'package:envigame/constants.dart';
import 'package:envigame/game/howto_world.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart'
    show TextStyle, Colors, FontWeight, Color;
import 'package:http/http.dart' as http;
import 'dart:convert';

class HowToGame extends FlameGame<HowToWorld> with HasCollisionDetection {
  String? employeeId;
  String? employeeName;
  HowToGame()
    : super(
        world: HowToWorld(),
        camera: CameraComponent.withFixedResolution(
          width: gameWidth,
          height: gameHeight,
        ),
      );
  int score = 0;
  final String scriptUrl =
      'https://script.google.com/macros/s/AKfycbxolsN0RIvvW5UMOrF3ZRJ2FXq1wY_xa2eTuKV1rgCcttvRnoFbhc92OLne7CX7VHhIBw/exec';
  double countdown = 15.0;
  late TextComponent scoreText;
  late TextComponent timerText;
  @override
  Color backgroundColor() => const Color(0xfffbf2e3);
  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 2. ทำให้เกมหยุดรอในตอนแรก และสั่งให้แสดงหน้าจอ 'StartScreen'
    paused = true;
    overlays.add('StartScreen');

    // 3. สร้าง UI แสดงคะแนนและเวลาเตรียมไว้ แต่ยังไม่เริ่มนับ
    scoreText = TextComponent(
      text: 'Score: 0',
      position: Vector2(20, 20),
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 60,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    timerText = TextComponent(
      text: 'Time: ${countdown.toStringAsFixed(1)}',
      position: Vector2(size.x - 20, 20),
      anchor: Anchor.topRight,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 60,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    // เพิ่ม UI เข้าไปใน Camera.viewport เพื่อให้มันอยู่นิ่งๆ
    camera.viewport.add(scoreText);
    camera.viewport.add(timerText);
  }

  // 4. สร้างฟังก์ชันสำหรับเริ่มเกม (จะถูกเรียกจาก UI)
  void startGame({required String id, required String name}) {
    // เก็บข้อมูลผู้เล่น
    employeeId = id;
    employeeName = name;

    // Reset ค่าและสร้าง World
    score = 0;
    countdown = 60.0;
    world = HowToWorld();
    add(world);

    // ซ่อนหน้าจอเริ่มต้นและเริ่มเกม
    overlays.remove('StartScreen');
    paused = false;
  }

  // 5. สร้างฟังก์ชันสำหรับ Reset เกมทั้งหมด (กลับไปหน้าเริ่มต้น)
  void resetGame() {
    // ลบ World เก่าทิ้ง
    world.removeFromParent();
    // Reset ค่าต่างๆ
    scoreText.text = 'Score: 0';
    timerText.text = 'Time: 60.0';

    // กลับไปแสดงหน้าจอเริ่มต้น และหยุดเกม
    paused = true;
    overlays.add('StartScreen');
  }

  // ฟังก์ชันเพิ่มคะแนน (Player จะเรียกใช้ฟังก์ชันนี้)
  void increaseScore() {
    score += 2;
    scoreText.text = 'Score: $score';
  }

  Future<void> _submitScore() async {
    if (employeeId == null || employeeName == null) {
      print("Player data is missing. Cannot submit score.");
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(scriptUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "employeeId": employeeId,
          "gameId": "game2",
          "score": score,
        }),
      );

      if (response.statusCode == 200) {
        print("Score submitted successfully: ${response.body}");
      } else {
        print(
          "Score submission might be successful with status: ${response.statusCode}",
        );
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error submitting score: $e");
    }
  }

  // ✅ 4. สร้างฟังก์ชันกลางสำหรับจบเกม
  void endGame() {
    if (paused) return; // ป้องกันการเรียกซ้ำ

    paused = true;
    countdown = 0;
    timerText.text = 'Time: 0.0';

    // เรียกใช้ฟังก์ชันส่งข้อมูลก่อนแสดงหน้าจอ Game Over
    _submitScore();

    overlays.add('GameOver');
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!paused) {
      if (countdown > 0) {
        countdown -= dt;
        timerText.text = 'Time: ${countdown.toStringAsFixed(1)}';

        if (countdown <= 0) {
          // ✅ 5. เรียกใช้ฟังก์ชัน endGame เมื่อเวลาหมด
          endGame();
        }
      }
    }
  }
}
