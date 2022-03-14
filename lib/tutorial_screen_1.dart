import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_sliding_puzzle/tutorial_screen_2.dart';

import 'common/theme/custom_colors.dart';

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
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Image.asset(
                'assets/images/tutorial_1.png',
              ),
            ),
            const Spacer(),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                side: const BorderSide(width: 1, color: CustomColors.expectedMelodyButton),
              ),
              onPressed: () {
                Get.toNamed(TutorialScreen2.ROUTE);
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  "Next",
                  style: Theme.of(context).textTheme.headline3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
