import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/data/model/position.dart';
import 'package:music_sliding_puzzle/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/data/model/tile.dart';

class PuzzleBoardController extends GetxController {
  PuzzleBoardController({this.random});

  static const _PUZZLE_SIZE = 4;
  final Random? random;
  late Puzzle puzzleState; // todo move to state object which should be observed

  // final PuzzleStatus puzzleStatus; todo add puzzleStatus

  @override
  void onInit() {
    puzzleState = _generatePuzzle(_PUZZLE_SIZE).sort();
    debugPrint("TEST PuzzleBoardController onInit puzzle generated");
    super.onInit();
  }

  /// Build a list of tiles - giving each tile their correct position and current position.
  Puzzle _generatePuzzle(int size, {bool shuffle = true}) {
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: size, y: size);

    // Create all possible board positions.
    for (var y = 1; y <= size; y++) {
      for (var x = 1; x <= size; x++) {
        if (x == size && y == size) {
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
      size,
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
          size,
          correctPositions,
          currentPositions,
        );
        puzzle = Puzzle(tiles: tiles);
      }
    }

    return puzzle;
  }

  List<Tile> _getTileListFromPositions(
    int size,
    List<Position> correctPositions,
    List<Position> currentPositions,
  ) {
    final whitespacePosition = Position(x: size, y: size);
    return [
      for (int i = 1; i <= size * size; i++)
        if (i == size * size)
          Tile(
            value: i,
            correctPosition: whitespacePosition,
            currentPosition: currentPositions[i - 1],
            isWhitespace: true,
          )
        else
          Tile(
            value: i,
            correctPosition: correctPositions[i - 1],
            currentPosition: currentPositions[i - 1],
          )
    ];
  }

  // todo there are different possible results: complete/incomplete=>isMovable=>move=>complete/incomplete, also isNotMovable
  void move(Tile tappedTile) {
    if (puzzleState.isTileMovable(tappedTile)) {
      final mutablePuzzle = Puzzle(tiles: [...puzzleState.tiles]);
      final movedPuzzle = mutablePuzzle.moveTiles(tappedTile, []);
      if (movedPuzzle.isComplete()) {
        // todo
      } else {
        // puzzleState = movedPuzzle;
        puzzleState = movedPuzzle.sort();
        update();
      }
    } else {
      debugPrint("TEST Tile is not movable");
      // todo
    }
  }
}
