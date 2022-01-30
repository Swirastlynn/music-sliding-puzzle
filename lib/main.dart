import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:music_sliding_puzzle/data/sounds_library.dart';
import 'package:music_sliding_puzzle/presentation/puzzle_controller.dart';

import 'level.dart';
import 'view/puzzle_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Music Sliding Puzzle'),
      initialBinding: AppBinding(),
    );
  }
}

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Level level = Level(size: 4, stage: 1);
    AudioPlayer audioPlayer = AudioPlayer(playerId: 'my_unique_playerId');
    AudioCache audioCache = AudioCache( // WARNING: AudioCache is not available for Flutter Web.
      prefix: 'assets/audio/',
      fixedPlayer: audioPlayer,
    );
    var soundLibrary = SoundLibrary(
      audioCache: audioCache,
      stage: level.stage, // todo for more Levels, keep global GameState in this class
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
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Center(
        child: PuzzleView(),
      ),
    );
  }
}
