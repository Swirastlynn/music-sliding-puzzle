import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/data/model/position.dart';
import 'package:music_sliding_puzzle/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/data/model/tile.dart';
import 'package:music_sliding_puzzle/data/sounds_library.dart';
import 'package:music_sliding_puzzle/presentation/puzzle_state.dart';

class PuzzleController extends GetxController {
  PuzzleController({required this.soundLibrary, required this.levelSize, this.random});

  final SoundLibrary soundLibrary;
  final int levelSize;
  final Random? random;

  late Rx<PuzzleState> puzzleState;

  get puzzle => puzzleState.value.puzzle;

  @override
  void onInit() {
    puzzleState = PuzzleState(puzzle: _generatePuzzle().sort()).obs;
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

  // todo there are different possible results: complete/incomplete=>isMovable=>move=>complete/incomplete, also isNotMovable
  void tapTile(Tile tappedTile) {
    soundLibrary.playSound(tappedTile);

    if (puzzleState.value.puzzle.isTileMovable(tappedTile)) {
      final mutablePuzzle = Puzzle(tiles: [...puzzleState.value.puzzle.tiles]);
      final movedPuzzle = mutablePuzzle.moveTiles(tappedTile, []);
      if (movedPuzzle.isComplete()) {
        // todo
      } else {
        // playLocal() async {
        //   Uint8List byteData =
        // int result = await audioPlayer.play();
        // }
        puzzleState.update((state) {
          state?.puzzle = movedPuzzle.sort();
        });
      }
    } else {
      debugPrint("TEST Tile is not movable");
      // todo
    }
  }
}
