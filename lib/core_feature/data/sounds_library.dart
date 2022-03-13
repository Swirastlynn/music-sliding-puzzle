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
  ];

  final List<String> _reversedSoundsPaths = [
    'G_major_scale_15.mp3',
    'G_major_scale_14.mp3',
    'G_major_scale_13.mp3',
    'G_major_scale_12.mp3',
    'G_major_scale_11.mp3',
    'G_major_scale_10.mp3',
    'G_major_scale_9.mp3',
    'G_major_scale_8.mp3',
    'G_major_scale_7.mp3',
    'G_major_scale_6.mp3',
    'G_major_scale_5.mp3',
    'G_major_scale_4.mp3',
    'G_major_scale_3.mp3',
    'G_major_scale_2.mp3',
    'G_major_scale_1.mp3',
  ];

  final String _melodyPath = 'G_major_scale_full.wav';
  final String _reversedMelodyPath = 'G_major_scale_full_reverse.mp3';

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
    3: [
      "G5",
      "F5#",
      "E5",
      "D5",
      "C5",
      "B4",
      "A4",
      "G4",
      "F#4",
      "E4",
      "D4",
      "C4",
      "B3",
      "A3",
      "G3",
      "WHITESPACE_PLACEHOLDER"
    ],
  };

  String soundName(int index, int stage) =>
      _mapOfStagesToSoundNames.entries
          .elementAt(stage - 1)
          .value[index];

  void preload() {
    audioCache.loadAll([..._soundsPaths, ..._reversedSoundsPaths, _melodyPath, _reversedMelodyPath]);
  }

  void playSound(Tile tappedTile, int stage) {
    switch (stage) {
      case 1:
      case 2:
        audioCache.play(_soundsPaths[tappedTile.value - 1]);
        break;
      case 3:
        audioCache.play(_reversedSoundsPaths[tappedTile.value - 1]);
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
      case 3:
        audioCache.play(_reversedMelodyPath);
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
      case 3:
        int soundIndex = 0;
        int outOfBoundIndex = _reversedSoundsPaths.length;

        _subscription = audioCache.fixedPlayer?.onPlayerCompletion.listen(
              (event) {
            soundIndex++;
            if (soundIndex == outOfBoundIndex) {
              onMelodyComplete();
              _subscription?.cancel();
              return;
            }
            onSoundStart(soundIndex);
            audioCache.play(_reversedSoundsPaths[soundIndex]);
          },
        );

        // start playing
        audioCache.play(_reversedSoundsPaths[soundIndex]);
        onSoundStart(soundIndex);
        break;
      default:
        throw const UnexpectedStageNumberException();
    }
  }
}
