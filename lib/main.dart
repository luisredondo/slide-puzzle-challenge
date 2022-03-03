import 'dart:math';

import 'package:flutter/material.dart';

import 'level_transition.dart';
import 'ui/board_config.dart';
import 'ui/backdrop_paint.dart';
import 'ui/puzzle_level.dart';
import 'ui/tutorial_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Slide Puzzle: Escape of Cao Cao',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // Controls the backdrop painter to trigger color change.
  late final _backdropController = BackdropController();

  // Controls the level entrance animation.
  late final _levelBeginController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  );

  // Controls the level exit animation.
  late final _levelEndController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 2),
  );

  int _currentLevel = 0;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    // Calculate unit size: side-length (in logic pixels) of a 1x1 tile.
    final unitSize = min(screenSize.width / 6, screenSize.height / 8);
    return Scaffold(
      body: BoardConfig(
        unitSize: unitSize,
        child: Stack(
          children: [
            // Background: a custom painter wrapped in a repaint boundary
            // because the rest of the app usually updates at different times.
            RepaintBoundary(
              child: BackdropPaint(
                controller: _backdropController,
              ),
            ),
            if (_currentLevel == 0)
              TutorialDialog(
                onDismiss: _advanceToNextLevel,
              ),
            if (_currentLevel > 0)
              Center(
                child: ScaleTransition(
                  scale: CurveTween(curve: Curves.easeOut)
                      .animate(_levelBeginController),
                  child: LevelEndTransition(
                    animation: _levelEndController,
                    child: PuzzleLevel(
                      // A single level of the puzzle.
                      key: ValueKey(_currentLevel),
                      level: _currentLevel,
                      onWin: _onLevelCompleted,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _advanceToNextLevel() {
    _levelBeginController.forward(from: 0.0);
    _backdropController.celebrate();
    setState(() => _currentLevel++);
  }

  void _onLevelCompleted(int level, int steps) async {
    // Play animation: game board falling down and 3D piece spinning.
    await _levelEndController.forward();
    // Embrace the void: pause and find peace in the emptiness.
    await Future.delayed(const Duration(milliseconds: 300));
    // Reset the animation controller for the next time.
    _levelEndController.reset();
    // Continue on to the next level.
    _advanceToNextLevel();
  }
}
