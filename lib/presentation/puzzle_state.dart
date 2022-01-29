import 'package:music_sliding_puzzle/data/model/puzzle.dart';

class PuzzleState {
  PuzzleState({required this.puzzle, this.movesCounter = 0});
  Puzzle puzzle;
  int movesCounter;
}