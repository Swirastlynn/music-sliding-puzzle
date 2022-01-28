import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/data/model/position.dart';
import 'package:music_sliding_puzzle/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/data/model/tile.dart';
import 'package:music_sliding_puzzle/presentation/puzzle_state.dart';

class PuzzleController extends GetxController {
  PuzzleController(this.localMusicPlayer, {this.random});

  static const _puzzleSize = 4;

  final AudioCache localMusicPlayer;
  final Random? random;

  late Rx<PuzzleState> puzzleState;

  get puzzle => puzzleState.value.puzzle;

  @override
  void onInit() {
    // localMusicPlayer.loadAll(
    //     ['assets/audio/G_major_scale_1.mp3', 'assets/audio/G_major_scale_2.mp3',
    //       'assets/audio/G_major_scale_3.mp3', 'assets/audio/G_major_scale_4.mp3',
    //       'assets/audio/G_major_scale_5.mp3', 'assets/audio/G_major_scale_6.mp3',
    //       'assets/audio/G_major_scale_7.mp3', 'assets/audio/G_major_scale_8.mp3',
    //       'assets/audio/G_major_scale_9.mp3', 'assets/audio/G_major_scale_10.mp3',
    //       'assets/audio/G_major_scale_11.mp3', 'assets/audio/G_major_scale_12.mp3',
    //       'assets/audio/G_major_scale_13.mp3', 'assets/audio/G_major_scale_14.mp3',
    //       'assets/audio/G_major_scale_15.mp3',
    //     ]);
    puzzleState = PuzzleState(puzzle: _generatePuzzle(_puzzleSize).sort()).obs;
    debugPrint("TEST PuzzleController onInit puzzle generated");
    super.onInit();
  }

  /// Build a list of tiles - giving each tile their correct position and current position.
  Puzzle _generatePuzzle(int size, {bool shuffle = true}) {
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

  List<Tile> _getTileListFromPositions(int size,
      List<Position> correctPositions,
      List<Position> currentPositions,) {
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
  void moveTile(Tile tappedTile) {
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
        localMusicPlayer.play('G_major_scale_1.mp3');
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
