import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/theme/custom_colors.dart';
import 'core_feature/view/puzzle_view.dart';

class TutorialScreen1 extends StatelessWidget {
  static const ROUTE = '/tutorial_1';

  const TutorialScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
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
        child: Column(
          children: [
            const SizedBox(height: 48),
            Image.asset('assets/images/tutorial.png'),
            const Spacer(),
            Container(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: const StadiumBorder(),
                  side: const BorderSide(width: 1, color: CustomColors.expectedMelodyButton),
                ),
                onPressed: () {
                  Get.toNamed(PuzzleView.ROUTE);
                },
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    "Next",
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
