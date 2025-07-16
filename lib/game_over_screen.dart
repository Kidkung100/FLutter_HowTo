import 'package:flutter/material.dart';
import 'package:envigame/game/howto_game.dart';

class GameOverScreen extends StatelessWidget {
  final HowToGame game;
  const GameOverScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withAlpha(150),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Time\'s Up!',
              style: TextStyle(fontSize: 60, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Text(
              'Final Score: ${game.score}',
              style: const TextStyle(fontSize: 48, color: Colors.white),
            ),
            const SizedBox(height: 40),
            // ElevatedButton(
            // onPressed: () {
            // game.overlays.remove('GameOver');
            //game.resetGame();
            //},
            //child: const Text('Play Again', style: TextStyle(fontSize: 24)),
            //),
          ],
        ),
      ),
    );
  }
}
