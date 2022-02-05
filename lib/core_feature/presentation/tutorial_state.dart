class TutorialState {
  TutorialState({required this.tutorialPlayingTileNumber});

  int tutorialPlayingTileNumber = -1;

  get isTutorial => tutorialPlayingTileNumber > 0;
}
