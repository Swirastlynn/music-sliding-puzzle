import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:music_sliding_puzzle/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/data/model/tile.dart';
import 'package:music_sliding_puzzle/presentation/puzzle_board_controller.dart';

class PuzzleView extends StatelessWidget {
  const PuzzleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: GetBuilder(
        init: PuzzleBoardController(),
        builder: (PuzzleBoardController controller) {
          debugPrint("TEST create puzzle board");
          return _PuzzleBoard(puzzle: controller.puzzleState);
        },
      ),
    );
  }
}

/// Displays the board of the puzzle.
class _PuzzleBoard extends StatelessWidget {
  const _PuzzleBoard({Key? key, required this.puzzle}) : super(key: key);

  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    final size = puzzle.getDimension();
    if (size == 0) return const CircularProgressIndicator();
    return _SimplePuzzleBoard(
      key: const Key('simple_puzzle_board_small'),
      size: size,
      tiles: puzzle.tiles
          .map(
            (tile) => _PuzzleTile(
              key: Key('puzzle_tile_${tile.value.toString()}'),
              tile: tile,
            ),
          )
          .toList(),
    );
  }
}

class _SimplePuzzleBoard extends StatelessWidget {
  const _SimplePuzzleBoard({
    Key? key,
    required this.size,
    required this.tiles,
    this.spacing = 8,
  }) : super(key: key);

  final int size;
  final List<Widget> tiles;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: size,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: tiles,
    );
  }
}

class _PuzzleTile extends StatelessWidget {
  const _PuzzleTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    // final theme = context.select((ThemeBloc bloc) => bloc.state.theme);
    // final state = context.select((PuzzleBloc bloc) => bloc.state);

    return tile.isWhitespace
        ? const SizedBox()
        : _SimplePuzzleTile(
            key: Key('simple_puzzle_tile_${tile.value}_small'),
            tile: tile,
          );
  }
}

class _SimplePuzzleTile extends StatelessWidget {
  const _SimplePuzzleTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PuzzleBoardController(),
      builder: (PuzzleBoardController controller) {
        return TextButton(
          style: TextButton.styleFrom(
            // primary: PuzzleColors.white,
            // textStyle: PuzzleTextStyle.headline2.copyWith(
            //   fontSize: tileFontSize,
            // ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
          ).copyWith(),
          onPressed: () => {
            controller.move(tile) // todo is move appropriate naming at this scope?
          },
          child: Text(
            tile.value.toString(),
          ),
        );
      },
    );
  }
}
