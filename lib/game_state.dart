import 'level.dart';

class GameState {
  GameState({
    required this.level,
  });

  static const firstStage = 1;
  static const lastStage = 3;

  Level level;

  get isFirstStage => level.stage == firstStage;
  get isLastStage => level.stage == lastStage;

}
