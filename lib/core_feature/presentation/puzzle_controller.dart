import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/position.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/tile.dart';
import 'package:music_sliding_puzzle/core_feature/data/sounds_library.dart';
import 'package:music_sliding_puzzle/core_feature/presentation/puzzle_state.dart';
import 'package:music_sliding_puzzle/core_feature/presentation/tutorial_state.dart';

class PuzzleController extends GetxController {
  PuzzleController({
    required this.soundLibrary,
    required this.levelSize,
    required this.levelStage,
    this.random,
  });

  final SoundLibrary soundLibrary;
  final int levelSize;
  final int levelStage;
  final Random? random;

  late Rx<TutorialState> tutorialState;
  late Rx<PuzzleState> puzzleState;

  get isTutorial => tutorialState.value.isTutorial;

  get tutorialPlayingTileNumber => tutorialState.value.tutorialPlayingTileNumber;

  get puzzle => puzzleState.value.puzzle;

  get movesCounter => puzzleState.value.movesCounter;

  get playedNotesCounter => puzzleState.value.playedNotesCounter;

  @override
  void onInit() {
    tutorialState = TutorialState(tutorialPlayingTileNumber: -1).obs;
    puzzleState = PuzzleState(puzzle: _generatePuzzle().sort(), movesCounter: 0, playedNotesCounter: 0).obs;
    debugPrint("TEST PuzzleController onInit puzzle generated");
    super.onInit();
  }

  /// Build a list of tiles - giving each tile their correct position and current position.
  Puzzle _generatePuzzle({bool shuffle = true}) {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: levelSize, y: levelSize);

    // Create all possible positions.
    for (var y = 1; y <= levelSize; y++) {
      for (var x = 1; x <= levelSize; x++) {
        if (x == levelSize && y == levelSize) {
          correctPositions.add(whitespacePosition);
          currentPositions.add(whitespacePosition);
        } else {
          final position = Position(x: x, y: y);
          correctPositions.add(position);
          currentPositions.add(position);
        }
      }
    }

    if (shuffle) {
      // Randomize only the current tile positions.
      currentPositions.shuffle(random);
    }

    var tiles = _getTileListFromPositions(
      correctPositions,
      currentPositions,
    );

    var puzzle = Puzzle(tiles: tiles);

    if (shuffle) {
      // Assign the tiles new current positions until the puzzle is solvable and
      // zero tiles are in their correct position.
      while (!puzzle.isSolvable() || puzzle.getNumberOfCorrectTiles() != 0) {
        currentPositions.shuffle(random);
        tiles = _getTileListFromPositions(
          correctPositions,
          currentPositions,
        );
        puzzle = Puzzle(tiles: tiles);
      }
    }

    return puzzle;
  }

  List<Tile> _getTileListFromPositions(
    List<Position> correctPositions,
    List<Position> currentPositions,
  ) {
    final whitespacePosition = Position(x: levelSize, y: levelSize);
    return [
      for (int i = 1; i <= levelSize * levelSize; i++)
        if (i == levelSize * levelSize)
          Tile(
            value: i,
            name: soundLibrary.soundName(i - 1),
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          Tile(
            value: i,
            name: soundLibrary.soundName(i - 1),
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }

  void playTutorialMelody() {
    if (!isTutorial) {
      soundLibrary.playSoundsOneByOne(
        onSoundStart: (soundIndex) {
          tutorialState.update((state) {
            state?.tutorialPlayingTileNumber = soundIndex + 1;
          });
        },
        onMelodyComplete: () {
          tutorialState.update((state) {
            state?.tutorialPlayingTileNumber = -1;
          });
        },
      );
    }
  }

  void playTileSound(Tile tappedTile) {
    soundLibrary.playSound(tappedTile);
    puzzleState.update((state) {
      state?.playedNotesCounter += 1;
    });
  }

  // todo there are different possible results: complete/incomplete=>isMovable=>move=>complete/incomplete, also isNotMovable
  void moveTile(Tile tappedTile) {
    if (puzzleState.value.puzzle.isTileMovable(tappedTile)) {
      final mutablePuzzle = Puzzle(tiles: [...puzzleState.value.puzzle.tiles]);
      final movedPuzzle = mutablePuzzle.moveTiles(tappedTile, []);
      if (movedPuzzle.isComplete()) {
        // todo
      } else {
        puzzleState.update((state) {
          state?.puzzle = movedPuzzle.sort();
        });
      }
      puzzleState.update((state) {
        state?.movesCounter += 1;
      });
    } else {
      debugPrint("TEST Tile is not movable");
      // todo
    }
  }
}
