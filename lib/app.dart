import 'package:envigame/constants.dart';
import 'package:envigame/game/howto_game.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:envigame/game_over_screen.dart';

class GameApp extends StatefulWidget {
  const GameApp({super.key});

  @override
  State<GameApp> createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  late final HowToGame game;

  @override
  void initState() {
    super.initState();
    game = HowToGame();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: const Color(0xfffbf2e3),
        body: SafeArea(
          child: Center(
            child: FittedBox(
              child: SizedBox(
                width: gameWidth,
                height: gameHeight,
                child: GameWidget.controlled(
                  gameFactory: () => game,
                  overlayBuilderMap: {
                    'GameOver': (context, gameInstance) {
                      return GameOverScreen(game: gameInstance as HowToGame);
                    },
                    'StartScreen': (context, gameInstance) {
                      return StartScreen(game: gameInstance as HowToGame);
                    },
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Widget สำหรับหน้าจอเริ่มต้น (อัปเดตแล้ว)
class StartScreen extends StatefulWidget {
  final HowToGame game;
  const StartScreen({super.key, required this.game});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  double _formScale = 1.0;

  @override
  void initState() {
    super.initState();
    _idFocusNode.addListener(_handleFocusChange);
    _nameFocusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _idFocusNode.removeListener(_handleFocusChange);
    _nameFocusNode.removeListener(_handleFocusChange);
    _idFocusNode.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    final hasFocus = _idFocusNode.hasFocus || _nameFocusNode.hasFocus;
    setState(() {
      _formScale = hasFocus ? 1.1 : 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/start_background.png', fit: BoxFit.cover),
        GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Material(
            color: Colors.transparent,
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: IntrinsicHeight(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 40.0,
                          horizontal: 20.0,
                        ),
                        child: Column(
                          children: [
                            // HOW TO PLAY
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Column(
                                children: [
                                  Text(
                                    'วิธีการเล่น',
                                    style: TextStyle(
                                      fontSize: 48,
                                      color: Colors.yellow,
                                      fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 5.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'จิ้มเพื่อลากขยะให้ตรงกับสีของถังขยะแต่ละประเภท\nเพื่อเก็บคะแนนภายในเวลาที่กำหนด!',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 36,
                                      color: Colors.yellow,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 3.0,
                                          color: Colors.black,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const Spacer(), // ดันฟอร์มลงล่าง
                            // FORM
                            AnimatedScale(
                              scale: _formScale,
                              duration: const Duration(milliseconds: 300),
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: const EdgeInsets.all(24.0),
                                decoration: BoxDecoration(
                                  color: Colors.grey[850],
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 10,
                                      offset: Offset(0, 4),
                                    ),
                                  ],
                                ),
                                constraints: const BoxConstraints(
                                  maxWidth: 600,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'กรอกข้อมูลด้านล่างให้ถูกต้อง',
                                        style: TextStyle(
                                          fontSize: 36,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      TextFormField(
                                        controller: _idController,
                                        focusNode: _idFocusNode,
                                        style: const TextStyle(fontSize: 28),
                                        decoration: const InputDecoration(
                                          labelText: 'รหัสพนักงาน',
                                          labelStyle: TextStyle(fontSize: 28),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.all(16),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'กรุณากรอกรหัสพนักงาน';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 15),
                                      TextFormField(
                                        controller: _nameController,
                                        focusNode: _nameFocusNode,
                                        style: const TextStyle(fontSize: 28),
                                        decoration: const InputDecoration(
                                          labelText: 'ชื่อ-สกุล',
                                          labelStyle: TextStyle(fontSize: 28),
                                          filled: true,
                                          fillColor: Colors.white,
                                          border: OutlineInputBorder(),
                                          contentPadding: EdgeInsets.all(16),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'กรุณากรอกชื่อ-สกุล';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 25),
                                      ElevatedButton(
                                        onPressed: () {
                                          if (_formKey.currentState!
                                              .validate()) {
                                            widget.game.startGame(
                                              id: _idController.text.trim(),
                                              name: _nameController.text.trim(),
                                            );
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 60,
                                            vertical: 30,
                                          ),
                                        ),
                                        child: const Text(
                                          'เริ่มเกม',
                                          style: TextStyle(fontSize: 28),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
