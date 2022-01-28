import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
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
    AudioPlayer audioPlayer = AudioPlayer();
    AudioCache audioCache = AudioCache(
      prefix: 'assets/audio/',
      fixedPlayer: audioPlayer,
    );
    audioCache.loadAll([
      'G_major_scale_1.mp3',
      'G_major_scale_2.mp3',
      'G_major_scale_3.mp3',
      'G_major_scale_4.mp3',
      'G_major_scale_5.mp3',
      'G_major_scale_6.mp3',
      'G_major_scale_7.mp3',
      'G_major_scale_8.mp3',
      'G_major_scale_9.mp3',
      'G_major_scale_10.mp3',
      'G_major_scale_11.mp3',
      'G_major_scale_12.mp3',
      'G_major_scale_13.mp3',
      'G_major_scale_14.mp3',
      'G_major_scale_15.mp3',
    ]);
    Get.lazyPut<PuzzleController>(
      () => PuzzleController(
        audioCache: audioCache,
        level: Level(size: 4, stage: 1), // todo for more Levels, keep global GameState in this class
      ),
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
      body: Center(
        child: PuzzleView(),
      ),
    );
  }
}
