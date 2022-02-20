import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sounds Slider',
      theme: CustomThemes.darkTheme,
      home: const MyHomePage(title: 'Sounds Slider'),
      initialBinding: AppBinding(),
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

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          // color: CustomColors.grayDark,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                stops: [0.1, 1],
                colors: [
                  CustomColors.gradientBottom,
                  CustomColors.gradientTop,
                ],
              ),
            ),
            child: const PuzzleView()),
      ),
    );
  }
}
