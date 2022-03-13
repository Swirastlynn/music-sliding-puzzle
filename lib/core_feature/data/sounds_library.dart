import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:music_sliding_puzzle/common/custom_exceptions.dart';

import 'model/tile.dart';

class SoundLibrary {
  SoundLibrary({required this.audioCache}) {
    preload();
  }

  final AudioCache audioCache;

  final List<String> _soundsPaths = [
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

  final String _melodyPath = 'stage1/G_major_scale_full.wav';

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
    2: [
      "",
      "A3",
      "B3",
      "",
      "D4",
      "E4",
      "F#4",
      "",
      "A4",
      "B4",
      "",
      "D5",
      "E5",
      "F5#",
      "",
      "WHITESPACE_PLACEHOLDER"
    ],
  };

  String soundName(int index, int stage) =>
      _mapOfStagesToSoundNames.entries
          .elementAt(stage - 1)
          .value[index];

  void preload() {
    audioCache.loadAll([..._soundsPaths, _melodyPath]);
  }

  void playSound(Tile tappedTile, int stage) {
    switch (stage) {
      case 1:
      case 2:
        audioCache.play(_soundsPaths[tappedTile.value - 1]);
        break;
      default:
        throw const UnexpectedStageNumberException();
    }
  }

  void playFullTrack(int stage) {
    switch (stage) {
      case 1:
      case 2:
        audioCache.play(_melodyPath);
        break;
      default:
        throw const UnexpectedStageNumberException();
    }
  }

  void playSoundsOneByOne(int stage,
      {required void Function(int soundIndex) onSoundStart,
        required void Function() onMelodyComplete}) {
    StreamSubscription<void>? _subscription;
    switch (stage) {
      case 1:
      case 2:
        int soundIndex = 0;
        int outOfBoundIndex = _soundsPaths.length;

        _subscription = audioCache.fixedPlayer?.onPlayerCompletion.listen(
              (event) {
            soundIndex++;
            if (soundIndex == outOfBoundIndex) {
              onMelodyComplete();
              _subscription?.cancel();
              return;
            }
            onSoundStart(soundIndex);
            audioCache.play(_soundsPaths[soundIndex]);
          },
        );

        // start playing
        audioCache.play(_soundsPaths[soundIndex]);
        onSoundStart(soundIndex);
        break;
      default:
        throw const UnexpectedStageNumberException();
    }
  }
}
