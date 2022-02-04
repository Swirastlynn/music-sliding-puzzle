import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/data/model/tile.dart';
import 'package:music_sliding_puzzle/presentation/puzzle_controller.dart';

class PuzzleView extends StatefulWidget {
  const PuzzleView({Key? key}) : super(key: key);

  @override
  State<PuzzleView> createState() => _PuzzleViewState();
}

class _PuzzleViewState extends State<PuzzleView> with AfterLayoutMixin<PuzzleView> {
  final PuzzleController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(24),
              child: Obx(() => Text("Moves: ${controller.movesCounter.toString()}"))),
          Container(
            padding: const EdgeInsets.only(top: 96),
            child: Obx(() => _Board(puzzle: controller.puzzle)),
          ),
        ],
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    controller.playMelody();
  }
}

class _Board extends StatelessWidget {
  const _Board({Key? key, required this.puzzle}) : super(key: key);

  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    final size = puzzle.getDimension();
    if (size == 0) return const CircularProgressIndicator();
    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: size,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: puzzle.tiles
          .map(
            (tile) => _Tile(
              key: Key('tile_${tile.value.toString()}'),
              tile: tile,
            ),
          )
          .toList(),
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    return tile.isWhitespace
        ? const _WhitespaceTile()
        : _MusicTile(
            key: Key('simple_tile_${tile.value}'),
            tile: tile,
          );
  }
}

class _WhitespaceTile extends StatelessWidget {
  const _WhitespaceTile({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }
}

class _MusicTile extends GetView<PuzzleController> {
  const _MusicTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => TextButton(
        style: TextButton.styleFrom(
          backgroundColor: controller.isTutorial
              ? (tile.value == controller.tutorialPlayingTileNumber)
                  ? Colors.redAccent
                  : const Color.fromRGBO(220, 220, 220, 1.0)
              : tile.isCorrect()
                  ? Colors.lightGreen
                  : const Color.fromRGBO(220, 220, 220, 1.0),
          // todo define theme and use it, GetX has built-in support
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
          controller.tapTile(tile),
        },
        child: Text(
          tile.name,
        ),
      ),
    );
  }
}
