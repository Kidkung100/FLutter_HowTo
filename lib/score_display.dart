import 'package:envigame/game/howto_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

// Score component to be added to the Flame game
class ScoreDisplay extends TextComponent with HasGameReference<HowToGame> {
  int score;

  ScoreDisplay({this.score = 0})
    : super(
        text: 'Score: 0',
        position: Vector2(840, 20),
        textRenderer: TextPaint(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 128,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  void increaseScore(int value) {
    score += value;
    text = 'Score: $score';
  }

  void resetScore() {
    score = 0;
    text = 'Score: 0';
  }
}
