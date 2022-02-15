import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/common/theme/custom_colors.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/puzzle.dart';
import 'package:music_sliding_puzzle/core_feature/data/model/tile.dart';
import 'package:music_sliding_puzzle/core_feature/presentation/puzzle_controller.dart';

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
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(24),
              child: Obx(() => Text("Moves: ${controller.movesCounter.toString()}"))),
          Container(
            padding: const EdgeInsets.only(top: 144),
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
    return Container(
      padding: const EdgeInsets.all(3),
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
  const _MusicTile({
    Key? key,
    required this.tile,
  }) : super(key: key);

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
                  ? CustomColors.indigo
                  : CustomColors.goldenRod
                  : tile.isCorrect()
                  ? CustomColors.indigo
                  : CustomColors.goldenRod,
            ),
          ),
          color: controller.isTutorial
              ? (tile.value == controller.tutorialPlayingTileNumber)
              ? CustomColors.goldenRod
              : CustomColors.transparent
              : tile.isCorrect()
              ? CustomColors.goldenRod
              : CustomColors.transparent,
        child: InkResponse(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Ink(
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
                      color: CustomColors.gradientBottom,
                      size: 20.0,
                    ),
                  ],
                ),
              ),
              const MusicTileScale(),
            ],
          ),
          onTap: () {
            controller.tapTile(tile);
          },
        ),
      ),
    );
  }
}

class MusicTileScale extends StatefulWidget { // todo or intercept touch event, or pass the event from the top to here
  const MusicTileScale({Key? key}) : super(key: key);

  @override
  State<MusicTileScale> createState() => MusicTileScaleState();
}

class MusicTileScaleState extends State<MusicTileScale> {
  double _scale = 1.0;
  double _visible = 1.0;

  void _changeScale() {
    setState(() => _scale = _scale == 1.0 ? 1.2 : 1.0);
  }

  void _changeVisibility() {
    setState(() => _visible = _visible == 1.0 ? 0.0 : 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible,
      duration: const Duration(milliseconds: 200),
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 200),
        child: Container(
          decoration: ShapeDecoration(
            shape: CircleBorder(
              side: BorderSide(
                width: _scale,
                color: CustomColors.goldenRod,
              ),
            ),
          ),
        ),
      ),
    );
  }
}