import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:music_sliding_puzzle/data/model/tile.dart';

class SoundLibrary {
  SoundLibrary({required this.audioCache, required this.stage}) {
    preload();
  }

  final AudioCache audioCache;
  final int stage;

  final List<String> _soundsPathsStage1 = [
    'stage1/G_major_scale_1.mp3',
    'stage1/G_major_scale_2.mp3',
    'stage1/G_major_scale_3.mp3',
    'stage1/G_major_scale_4.mp3',
    'stage1/G_major_scale_5.mp3',
    'stage1/G_major_scale_6.mp3',
    'stage1/G_major_scale_7.mp3',
    'stage1/G_major_scale_8.mp3',
    'stage1/G_major_scale_9.mp3',
    'stage1/G_major_scale_10.mp3',
    'stage1/G_major_scale_11.mp3',
    'stage1/G_major_scale_12.mp3',
    'stage1/G_major_scale_13.mp3',
    'stage1/G_major_scale_14.mp3',
    'stage1/G_major_scale_15.mp3',
  ];

  final String _melodyPathStage1 = 'stage1/G_major_scale_full.wav';

  final _mapOfStagesToSoundNames = {
    1: [
      "G3",
      "A3",
      "B3",
      "C4",
      "D4",
      "E4",
      "F#4",
      "G4",
      "A4",
      "B4",
      "C5",
      "D5",
      "E5",
      "F5#",
      "G5",
      "WHITESPACE_PLACEHOLDER"
    ],
  };

  String soundName(int index) => _mapOfStagesToSoundNames.entries.elementAt(stage - 1).value[index];

  void preload() {
    audioCache.loadAll([..._soundsPathsStage1, _melodyPathStage1]);
  }

  void playSound(Tile tappedTile) {
    switch (stage) {
      case 1:
        audioCache.play(_soundsPathsStage1[tappedTile.value]);
        break;
      default:
        throw Exception("Unexpected stage number"); // todo custom exceptions class
    }
  }

  void playFullTrack() {
    switch (stage) {
      case 1:
        audioCache.play(_melodyPathStage1);
        break;
      default:
        throw Exception("Unexpected stage number"); // todo custom exceptions class
    }
  }

  void playTilesOneByOne(void Function(int counter) onComplete) {
    StreamSubscription<void>? _subscription;
    switch (stage) {
      case 1:
        int counter = 1;
        int soundsThreshold = _soundsPathsStage1.length;
        _subscription = audioCache.fixedPlayer?.onPlayerCompletion.listen(
          (event) {
            onComplete(counter);
            counter++;
            if (counter == soundsThreshold) {
              _subscription?.cancel();
              return;
            }
            audioCache.play(_soundsPathsStage1[counter]);
          },
        );
        audioCache.play(_soundsPathsStage1[0]);
        break;
      default:
        throw Exception("Unexpected stage number"); // todo custom exceptions class
    }
  }
}
