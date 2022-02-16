import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/common/theme/custom_colors.dart';

class SoundAnimationWidget extends StatelessWidget {
  const SoundAnimationWidget(this.controller, {Key? key}) : super(key: key);
  static const int _duration = 300;

  final SoundAnimationStateController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedOpacity(
        opacity: controller.getVisibility,
        duration: const Duration(milliseconds: _duration),
        child: AnimatedScale(
          scale: controller.getScale,
          duration: const Duration(milliseconds: _duration),
          child: Container(
            decoration: ShapeDecoration(
              shape: CircleBorder(
                side: BorderSide(
                  width: controller.getScale,
                  color: CustomColors.goldenRod,
                ),
              ),
            ),
          ),
          onEnd: () {
            // todo reset state without animation.
            controller.resetAnimation();
          },
        ),
      ),
    );
  }
}

class SoundAnimationStateController extends GetxController {
  final _scale = 1.0.obs;
  final _visibility = 1.0.obs;

  double get getScale => _scale.value;

  double get getVisibility => _visibility.value;

  void changeScale() {
    _scale.value = _scale.value == 1.0 ? 1.2 : 1.0;
  }

  void changeVisibility() {
    _visibility.value = _visibility.value == 1.0 ? 0.0 : 1.0;
  }

  void resetAnimation() {
    _visibility.value = 1.0;
    _scale.value = 1.0;
  }
}
