import 'package:flutter/widgets.dart';

/// Defines the color palette for the puzzle UI.
abstract class CustomColors {

/// palette
  static const Color _atoll = Color(0xFF0E618A);
  static const Color _tarawera = Color(0xFF0A4059);
  static const Color _cornflowerBlue = Color(0xFF09242E);
  static const Color _indigo = Color(0xFF044E74);
  static const Color _indigoContrast = Color(0xFF00ACC1);
  static const Color _blueSapphire = Color(0xFF024C64);

  static const Color _green = Color(0xFF52B342);
  static const Color _greenContrast = Color(0xFF12443E);

  static const Color _goldenRod = Color(0xFFE9AD2A);
  static const Color _goldenRodContrast = Color(0xFF30473F);
  static const Color _goldenRodTransparent = Color(0x57E9AD2A);

  static const Color _winterSunsetSky = Color(0xFFFF1D6D);

  static const Color _richBlack = Color(0xFF000D13);

  static const Color _white = Color(0xFFFFFFFF);
  static const Color _black = Color(0xFF000000);
  static const Color _transparent = Color(0x00000000);
  static const Color _gray = Color(0xFF999999);


/// features
  static const Color primary = _indigo;
  static const Color outlineButton = _indigoContrast;
  static const Color elevatedButtonBg = _indigoContrast;
  static const Color statusBar = _richBlack;
  static const Color systemNavigationBar = _transparent;

  static const Color gradientTop = _richBlack;
  static const Color gradientMiddle = _tarawera;
  static const Color gradientBottom = _atoll;

  static const Color playingTutorialTileBg = _goldenRod;
  static const Color tutorialTileBg = _transparent;
  static const Color playingTileBg = _goldenRod;
  static const Color tileBg = _transparent;
  static const Color playingTutorialTileBorder = _indigo;
  static const Color tutorialTileBorder = _gray;
  static const Color correctTileBorder = _indigo;
  static const Color incorrectTileBorder = _goldenRod;

  static const Color soundAnimation = _goldenRod;
  static const Color noteIconOnLightBg = _cornflowerBlue;
  static const Color noteIconOnDarkBg = _atoll;
  static const Color levelButton = _goldenRod;

  static const Color expectedMelodyButton = _goldenRod;


}