import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/data/model/position.dart';
import 'package:music_sliding_puzzle/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/data/model/tile.dart';
import 'package:music_sliding_puzzle/level.dart';
import 'package:music_sliding_puzzle/presentation/puzzle_state.dart';

class PuzzleController extends GetxController {
  PuzzleController({required this.audioCache, required this.level, this.random});

  final AudioCache audioCache;
  final Level level;
  final Random? random;

  late Rx<PuzzleState> puzzleState;

  get puzzle => puzzleState.value.puzzle;

  @override
  void onInit() {
    puzzleState = PuzzleState(puzzle: _generatePuzzle(level).sort()).obs;
    debugPrint("TEST PuzzleController onInit puzzle generated");
    super.onInit();
  }

  /// Build a list of tiles - giving each tile their correct position and current position.
  Puzzle _generatePuzzle(Level level, {bool shuffle = true}) {
    final size = level.size;
    final stage = level.stage;
    final correctPositions = <Position>[];
    final currentPositions = <Position>[];
    final whitespacePosition = Position(x: size, y: size);

    // Create all possible positions.
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
  void tapTile(Tile tappedTile) {
    audioCache.play('G_major_scale_1.mp3');

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