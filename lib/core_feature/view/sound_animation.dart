import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/common/theme/custom_colors.dart';

import '../presentation/puzzle_controller.dart';

class SoundAnimationWidget extends StatefulWidget {
  const SoundAnimationWidget({required this.onTap, Key? key}) : super(key: key);

  final void Function() onTap;

  @override
  State<SoundAnimationWidget> createState() => _SoundAnimationWidgetState();
}

class _SoundAnimationWidgetState extends State<SoundAnimationWidget> with TickerProviderStateMixin {
  static const int _duration = 300;
  late final AnimationController _soundAnimationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  final PuzzleController controller = Get.find();

  @override
  void initState() {
    super.initState();
    _soundAnimationController = AnimationController(
      duration: const Duration(milliseconds: _duration),
      vsync: this,
    );
    _scaleAnimation = Tween(begin: 1.0, end: 1.25).animate(
        CurvedAnimation(
          parent: _soundAnimationController,
          curve: Curves.fastOutSlowIn,
        ),
    );
    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
          parent: _soundAnimationController,
          curve: Curves.fastOutSlowIn,
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!controller.isTutorial) {
          _soundAnimationController.forward(from: 0.0);
          widget.onTap();
        }
      },
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: Container(
            decoration: const ShapeDecoration(
              shape: CircleBorder(
                side: BorderSide(
                  width: 1,
                  color: CustomColors.soundAnimation,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _soundAnimationController.dispose();
  }
}
