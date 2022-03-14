import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/common/theme/custom_colors.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/tile.dart';
import 'package:music_sliding_puzzle/core_feature/presentation/puzzle_controller.dart';

import 'shake_animation.dart';
import 'wave_animation.dart';

class PuzzleScreen extends StatelessWidget {
  static const ROUTE = '/puzzle_view';

  PuzzleScreen({Key? key}) : super(key: key);

  final PuzzleController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomLeft,
          stops: [0, 0.28, 1],
          colors: [
            CustomColors.gradientTop,
            CustomColors.gradientMiddle,
            CustomColors.gradientBottom,
          ],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(
            height: 24,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Obx(
                  () => Opacity(
                    opacity: (!controller.isFirstStage) ? 1.0 : 0.0,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(width: 1, color: CustomColors.expectedMelodyButton),
                      ),
                      onPressed: () {
                        controller.goToPreviousLevel();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "<-",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Obx(
                    () => Text(
                  "Level ${controller.levelStage.toString()}",
                  style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: CustomColors.levelButton,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Obx(
                  () => Opacity(
                    opacity: (!controller.isLastStage) ? 1.0 : 0.0,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        shape: const StadiumBorder(),
                        side: const BorderSide(width: 1, color: CustomColors.expectedMelodyButton),
                      ),
                      onPressed: () {
                        controller.goToNextLevel();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          "->",
                          style: Theme.of(context).textTheme.headline3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Obx(
            () => Text(
              "Moves: ${controller.movesCounter.toString()}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Obx(
            () => Text(
              "Played notes: ${controller.playedNotesCounter.toString()}",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          const Spacer(),
          Obx(
            () => _Board(puzzle: controller.puzzle),
          ),
          const SizedBox(height: 8),
          Obx(
            () => (controller.isComplete) ? _Congrats() : const Expanded(child: SizedBox.shrink()),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: const BorderSide(width: 1, color: CustomColors.expectedMelodyButton),
                ),
                onPressed: () {
                  controller.playTutorialMelody();
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Listen to the melody",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
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

class _MusicTile extends StatelessWidget {
  _MusicTile({Key? key, required this.tile}) : super(key: key);

  final GlobalKey<ShakeAnimationWidgetState> shakeWidgetKey =
      GlobalKey<ShakeAnimationWidgetState>();
  final PuzzleController controller = Get.find();
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
                    ? CustomColors.playingTutorialTileBorder
                    : CustomColors.tutorialTileBorder
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
            ShakeAnimationWidget(
              key: shakeWidgetKey,
              child: Column(
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
                    color: CustomColors.noteIconOnLightBg,
                    size: 20.0,
                  ),
                ],
              ),
            ),
            WaveAnimationWidget(
              onTap: () {
                if (controller.isTileMovable(tile)) {
                  controller.moveTile(tile);
                } else {
                  shakeWidgetKey.currentState?.shake();
                }
              },
              onDoubleTap: () {
                controller.playTileSound(tile);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _Congrats extends StatelessWidget {
  _Congrats({Key? key}) : super(key: key);

  final PuzzleController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    controller.playFullTrack();
    return Text(
      "Congrats!",
      style: Theme.of(context).textTheme.headline2,
    );
  }
}
