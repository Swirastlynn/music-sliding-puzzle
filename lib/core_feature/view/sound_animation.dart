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
        opacity: controller.visible,
        duration: const Duration(milliseconds: _duration),
        child: AnimatedScale(
          scale: controller.scale,
          duration: const Duration(milliseconds: _duration),
          child: Container(
            decoration: ShapeDecoration(
              shape: CircleBorder(
                side: BorderSide(
                  width: controller.scale,
                  color: CustomColors.goldenRod,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SoundAnimationStateController extends GetxController {
  final _scale = 1.0.obs;
  final _visible = 1.0.obs;

  double get scale => _scale.value;

  double get visible => _visible.value;

  void changeScale() {
    _scale.value = _scale.value == 1.0 ? 1.2 : 1.0;
  }

  void changeVisibility() {
    _visible.value = _visible.value == 1.0 ? 0.0 : 1.0;
  }
}
