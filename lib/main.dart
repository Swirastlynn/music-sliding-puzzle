import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:music_sliding_puzzle/tutorial_screen_1.dart';
import 'package:music_sliding_puzzle/common/theme/custom_colors.dart';
import 'package:music_sliding_puzzle/common/theme/custom_themes.dart';

import 'core_feature/data/sounds_library.dart';
import 'core_feature/presentation/puzzle_controller.dart';
import 'core_feature/view/puzzle_view.dart';
import 'level.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: CustomColors.statusBar,
      systemNavigationBarColor: CustomColors.systemNavigationBar,
    ),
  );
  runApp(const SoundingPuzzleApp());
}

class SoundingPuzzleApp extends StatelessWidget {
  const SoundingPuzzleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sounding Puzzle',
      theme: CustomThemes.darkTheme,
      home: const TutorialScreen1(),
      initialBinding: AppBinding(),
        getPages: [
          GetPage(
              name: TutorialScreen1.ROUTE,
              page: () => const TutorialScreen1(),
              transition: Transition.zoom
          ),
          GetPage(
              name: PuzzleView.ROUTE,
              page: () => PuzzleView(),
              transition: Transition.zoom
          ),
          // GetPage(
          //     name: TutorialScreen3.ROUTE,
          //     page: () => TutorialScreen3(),
          //     transition: Transition.zoom
          // ),
        ]
    );
  }
}

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Level level = Level(size: 4, stage: 1);
    AudioPlayer audioPlayer = AudioPlayer(playerId: 'my_unique_playerId');
    AudioCache audioCache = AudioCache(
      // WARNING: AudioCache is not available for Flutter Web.
      prefix: 'assets/audio/',
      fixedPlayer: audioPlayer,
    );
    var soundLibrary = SoundLibrary(
      audioCache: audioCache,
      stage: level.stage, // todo for more Levels, keep global GameState in MyApp class
    );
    Get.lazyPut<PuzzleController>(
      () {
        return PuzzleController(
          soundLibrary: soundLibrary,
          levelSize: level.size,
          levelStage: level.stage,
        );
      },
    );
  }
}