import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_sliding_puzzle/common/theme/custom_colors.dart';

class SoundAnimationWidget extends StatefulWidget {
  const SoundAnimationWidget({Key? key}) : super(key: key);

  @override
  State<SoundAnimationWidget> createState() => _SoundAnimationWidgetState();
}

class _SoundAnimationWidgetState extends State<SoundAnimationWidget> with TickerProviderStateMixin {
  static const int _duration = 300;
  late final AnimationController _soundAnimationController;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _soundAnimationController = AnimationController(
      duration: const Duration(milliseconds: _duration),
      vsync: this,
    );
    _scaleAnimation = Tween(begin: 1.0, end: 1.3).animate(_soundAnimationController);
    _opacityAnimation = Tween(begin: 1.0, end: 0.0).animate(_soundAnimationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _soundAnimationController.forward(from: 0.0);
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
                  color: CustomColors.goldenRod,
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
