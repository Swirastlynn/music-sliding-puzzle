import 'package:flutter/material.dart';
import 'package:music_sliding_puzzle/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/data/model/tile.dart';

/// Displays the board of the puzzle.
class PuzzleBoard extends StatelessWidget {
  const PuzzleBoard({Key? key, required this.puzzle}) : super(key: key);

  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    final size = puzzle.getDimension();
    if (size == 0) return const CircularProgressIndicator();
    return SimplePuzzleBoard(
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

class SimplePuzzleBoard extends StatelessWidget {
  const SimplePuzzleBoard({
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
      onPressed: () => {},
      child: Text(
        tile.value.toString(),
      ),
    );
  }
}
