import 'package:flutter/widgets.dart';

/// Defines the color palette for the puzzle UI.
abstract class CustomColors {
/// base

  static const Color atoll = Color(0xFF0E618A);
  static const Color tarawera = Color(0xFF0A4059);
  static const Color cornflowerBlue = Color(0xFF09242E);
  static const Color indigo = Color(0xFF044E74);
  static const Color indigoContrast = Color(0xFF00ACC1);
  static const Color blueSapphire = Color(0xFF024C64);

  static const Color green = Color(0xFF52B342);
  static const Color greenContrast = Color(0xFF12443E);

  static const Color goldenRod = Color(0xFFE9AD2A);
  static const Color goldenRodContrast = Color(0xFF30473F);
  static const Color goldenRodTransparent = Color(0x57E9AD2A);

  static const Color winterSunsetSky = Color(0xFFFF1D6D);

  static const Color richBlack = Color(0xFF000D13);

  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color gray = Color(0xFF999999);


/// features
  static const Color primary = indigo;
  static const Color statusBar = richBlack;
  static const Color systemNavigationBar = transparent;

  static const Color gradientTop = atoll;
  static const Color gradientBottom = tarawera;

  static const Color playingTutorialTileBg = goldenRod;
  static const Color tutorialTileBg = transparent;
  static const Color playingTileBg = goldenRod;
  static const Color tileBg = transparent;
  static const Color playingTutorialTileBorder = indigo;
  static const Color tutorialTileBorder = gray;
  static const Color correctTileBorder = indigo;
  static const Color incorrectTileBorder = goldenRod;

  static const Color soundAnimation = goldenRod;
  static const Color noteIcon = cornflowerBlue;


}