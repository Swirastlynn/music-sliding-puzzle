import 'package:audioplayers/audioplayers.dart';
import 'package:music_sliding_puzzle/data/model/tile.dart';

class SoundLibrary {
  SoundLibrary({required this.audioCache, required this.stage}) {
    preload();
  }

  final AudioCache audioCache;
  final int stage;

  static const List<String> sounds = [
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
    'stage1/G_major_scale_full.wav',
  ];

  void preload() {
    audioCache.loadAll(sounds);
  }

  void playSound(Tile tappedTile) {
    switch (stage) {
      case 1:
        audioCache.play('stage1/G_major_scale_${tappedTile.value}.mp3');
        break;
      default:
        throw Exception("Unexpected stage number"); // todo custom exceptions class
    }
  }

  void playFullTrack(Tile tappedTile) {
    switch (stage) {
      case 1:
        audioCache.play('stage1/G_major_scale_full.wav');
        break;
      default:
        throw Exception("Unexpected stage number"); // todo custom exceptions class
    }
  }
}
