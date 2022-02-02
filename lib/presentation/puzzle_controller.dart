import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/data/model/position.dart';
import 'package:music_sliding_puzzle/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/data/model/tile.dart';
import 'package:music_sliding_puzzle/data/sounds_library.dart';
import 'package:music_sliding_puzzle/presentation/puzzle_state.dart';
import 'package:music_sliding_puzzle/presentation/tutorial_state.dart';

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

  late Rx<TutorialState> tutorialState; // todo or info move to the Tile
  late Rx<PuzzleState> puzzleState;

  get alreadyPlayedTile => tutorialState.value.alreadyPlayedTileNumber;

  get puzzle => puzzleState.value.puzzle;

  get movesCounter => puzzleState.value.movesCounter;

  @override
  void onInit() {
    tutorialState = TutorialState(alreadyPlayedTileNumber: -1).obs;
    puzzleState = PuzzleState(puzzle: _generatePuzzle().sort(), movesCounter: 0).obs;
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

  void playMelody() {
    soundLibrary.playSoundsOneByOne(
      onSoundStart: (soundIndex) {
        tutorialState.update((state) {
          debugPrint("color tile: ${state?.alreadyPlayedTileNumber}");
          state?.alreadyPlayedTileNumber = soundIndex + 1;
        });
      },
      onMelodyComplete: () {
        tutorialState.update((state) {
          state?.alreadyPlayedTileNumber = -1;
        });
      },
    );
  }

  // todo there are different possible results: complete/incomplete=>isMovable=>move=>complete/incomplete, also isNotMovable
  void tapTile(Tile tappedTile) {
    soundLibrary.playSound(tappedTile);

    if (puzzleState.value.puzzle.isTileMovable(tappedTile)) {
      final mutablePuzzle = Puzzle(tiles: [...puzzleState.value.puzzle.tiles]);
      final movedPuzzle = mutablePuzzle.moveTiles(tappedTile, []);
      if (movedPuzzle.isComplete()) {
        // todo
      } else {
        puzzleState.update((state) {
          state?.puzzle = movedPuzzle.sort();
          state?.movesCounter = state.movesCounter;
        });
      }
    } else {
      debugPrint("TEST Tile is not movable");
      // todo
    }
  }
}
