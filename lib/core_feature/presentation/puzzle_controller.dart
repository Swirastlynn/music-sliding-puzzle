import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/position.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/tile.dart';
import 'package:music_sliding_puzzle/core_feature/data/sounds_library.dart';
import 'package:music_sliding_puzzle/core_feature/presentation/puzzle_state.dart';
import 'package:music_sliding_puzzle/core_feature/presentation/tutorial_state.dart';
import 'package:music_sliding_puzzle/game_state.dart';

class PuzzleController extends GetxController {
  PuzzleController({
    required this.soundLibrary,
    this.random,
  });

  final SoundLibrary soundLibrary;
  final Random? random;

  late Rx<TutorialState> tutorialState;
  late Rx<PuzzleState> puzzleState;
  late Rx<GameState> gameState;

  get isTutorial => tutorialState.value.isTutorial;

  get tutorialPlayingTileNumber => tutorialState.value.tutorialPlayingTileNumber;

  get isComplete => puzzleState.value.isComplete;

  get puzzle => puzzleState.value.puzzle;

  get puzzleDimension => puzzleState.value.puzzle.getDimension();

  get puzzleTiles => puzzleState.value.puzzle.tiles;

  get movesCounter => puzzleState.value.movesCounter;

  get playedNotesCounter => puzzleState.value.playedNotesCounter;

  get levelStage => gameState.value.level.stage;

  get levelSize => gameState.value.level.size;

  get isFirstStage => gameState.value.isFirstStage;

  get isLastStage => gameState.value.isLastStage;

  @override
  void onInit() {
    gameState = Get.find<GameState>().obs;
    tutorialState = TutorialState(tutorialPlayingTileNumber: -1).obs;
    puzzleState =
        PuzzleState(puzzle: _generatePuzzle().sort(), movesCounter: 0, playedNotesCounter: 0).obs;
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
        debugPrint("Not solvable puzzle, trying again");
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
            name: soundLibrary.soundName(i - 1, gameState.value.level.stage),
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          Tile(
            value: i,
            name: soundLibrary.soundName(i - 1, gameState.value.level.stage),
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }

  void playTutorialMelody() {
    if (!isTutorial) {
      soundLibrary.playSoundsOneByOne(
        gameState.value.level.stage,
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
    soundLibrary.playSound(tappedTile, gameState.value.level.stage);
    puzzleState.update((state) {
      state?.playedNotesCounter += 1;
    });
  }

  void playFullTrack() {
    soundLibrary.playFullTrack(gameState.value.level.stage);
  }

  void moveTile(Tile tappedTile) {
    final mutablePuzzle = Puzzle(tiles: [...puzzleState.value.puzzle.tiles]);
    final movedPuzzle = mutablePuzzle.moveTiles(tappedTile, []);
    if (movedPuzzle.isComplete()) {
      puzzleState.update((state) {
        state?.puzzle = movedPuzzle.sort();
        state?.isComplete = true;
      });
    } else {
      puzzleState.update((state) {
        state?.puzzle = movedPuzzle.sort();
        state?.isComplete = false;
      });
    }
    puzzleState.update((state) {
      state?.movesCounter += 1;
    });
  }

  bool isTileMovable(Tile tile) {
    return puzzleState.value.puzzle.isTileMovable(tile);
  }

  void goToPreviousLevel() {
    if (!tutorialState.value.isTutorial && gameState.value.level.stage > GameState.firstStage) {
      gameState.update((state) {
        state?.level.stage -= 1;
      });
      puzzleState.update((state) {
        state?.puzzle = _generatePuzzle().sort();
        state?.movesCounter = 0;
        state?.playedNotesCounter = 0;
      });
    }
  }

  void goToNextLevel() {
    if (!tutorialState.value.isTutorial && gameState.value.level.stage < GameState.lastStage) {
      gameState.update((state) {
        state?.level.stage += 1;
      });
      puzzleState.update((state) {
        state?.puzzle = _generatePuzzle().sort();
        state?.movesCounter = 0;
        state?.playedNotesCounter = 0;
      });
    }
  }
}
