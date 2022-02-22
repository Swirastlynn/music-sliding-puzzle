import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/common/theme/custom_colors.dart';

import '../presentation/puzzle_controller.dart';

class SoundAnimationWidget extends StatefulWidget {
  const SoundAnimationWidget({required this.onTap, Key? key, required this.onDoubleTap})
      : super(key: key);

  final void Function() onTap;
  final void Function() onDoubleTap;

  @override
  State<SoundAnimationWidget> createState() => _SoundAnimationWidgetState();
}

class _SoundAnimationWidgetState extends State<SoundAnimationWidget> with TickerProviderStateMixin {
  static const int _duration = 620;
  static const int _duration2 = 760;
  static const int _duration3 = 880;
  late final AnimationController _soundAnimationController;
  late final AnimationController _soundAnimationController2;
  late final AnimationController _soundAnimationController3;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _scaleAnimation2;
  late final Animation<double> _scaleAnimation3;
  late final Animation<double> _opacityAnimation;
  late final Animation<double> _opacityAnimation2;
  late final Animation<double> _opacityAnimation3;

  final PuzzleController controller = Get.find();

  @override
  void initState() {
    super.initState();
    _soundAnimationController = AnimationController(
      duration: const Duration(milliseconds: _duration),
      vsync: this,
    );
    _soundAnimationController2 = AnimationController(
      duration: const Duration(milliseconds: _duration2),
      vsync: this,
    );
    _soundAnimationController3 = AnimationController(
      duration: const Duration(milliseconds: _duration3),
      vsync: this,
    );
    _scaleAnimation = Tween(begin: 1.0, end: 1.5).animate(
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
    _scaleAnimation2 = Tween(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(
        parent: _soundAnimationController2,
        curve: const Interval(0.15, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    _opacityAnimation2 = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _soundAnimationController2,
        curve: const Interval(0.15, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    _scaleAnimation3 = Tween(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _soundAnimationController3,
        curve: const Interval(0.3, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
    _opacityAnimation3 = Tween(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _soundAnimationController3,
        curve: const Interval(0.3, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!controller.isTutorial) {
          widget.onTap();
        }
      },
      onDoubleTap: () {
        if (!controller.isTutorial) {
          _soundAnimationController.forward(from: 0.0);
          _soundAnimationController2.forward(from: 0.0);
          _soundAnimationController3.forward(from: 0.0);
          widget.onDoubleTap();
        }
      },
      child: Stack(
        children: [
          FadeTransition(
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
          FadeTransition(
            opacity: _opacityAnimation2,
            child: ScaleTransition(
              scale: _scaleAnimation2,
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
          FadeTransition(
            opacity: _opacityAnimation3,
            child: ScaleTransition(
              scale: _scaleAnimation3,
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
        ],
      ),
    );
  }

  @override
  void dispose() {
    _soundAnimationController.dispose();
  }
}
