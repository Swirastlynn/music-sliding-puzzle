import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/common/theme/custom_colors.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/tile.dart';
import 'package:music_sliding_puzzle/core_feature/presentation/puzzle_controller.dart';

import 'sound_animation.dart';

class PuzzleView extends StatelessWidget {
  PuzzleView({Key? key}) : super(key: key);

  final PuzzleController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            child: Obx(
              () => Text("Moves: ${controller.movesCounter.toString()}"),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 144),
            child: Obx(
              () => _Board(puzzle: controller.puzzle),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(24),
            child: OutlinedButton(
              onPressed: () {
                controller.playMelody();
              },
              child: Text(
                "SHOW TUTORIAL",
                style: Theme.of(context).textTheme.headline3,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Board extends StatelessWidget {
  const _Board({Key? key, required this.puzzle}) : super(key: key);

  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    final size = puzzle.getDimension();
    if (size == 0) return const CircularProgressIndicator();
    return Container(
      padding: const EdgeInsets.all(8),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12),
      //   border: Border.all(color: CustomColors.goldenRodTransparent, width: 1.5),
      // ),
      child: GridView.count(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: size,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        clipBehavior: Clip.none,
        children: puzzle.tiles
            .map(
              (tile) => _Tile(
                key: Key('tile_${tile.value.toString()}'),
                tile: tile,
              ),
            )
            .toList(),
      ),
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
  const _MusicTile({Key? key, required this.tile}) : super(key: key);

  final Tile tile;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Material(
        shape: CircleBorder(
          side: BorderSide(
            width: 1,
            color: controller.isTutorial
                ? (tile.value == controller.tutorialPlayingTileNumber)
                    ? CustomColors.correctTutorialTileBorder
                    : CustomColors.incorrectTutorialTileBorder
                : tile.isCorrect()
                    ? CustomColors.correctTileBorder
                    : CustomColors.incorrectTileBorder,
          ),
        ),
        color: controller.isTutorial
            ? (tile.value == controller.tutorialPlayingTileNumber)
                ? CustomColors.playingTutorialTileBg
                : CustomColors.tutorialTileBg
            : tile.isCorrect()
                ? CustomColors.playingTileBg
                : CustomColors.tileBg,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    tile.name,
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
                const Icon(
                  Icons.audiotrack,
                  color: CustomColors.noteIcon,
                  size: 20.0,
                ),
              ],
            ),
            SoundAnimationWidget(
                    onTap: () { controller.tapTile(tile); }
            ),
          ],
        ),
      ),
    );
  }
}
