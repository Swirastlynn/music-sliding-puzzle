import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_sliding_puzzle/common/theme/colors.dart';
import 'package:music_sliding_puzzle/common/theme/font_weights.dart';

/// Defines text styles for the puzzle UI.
class PuzzleTextStyle {

  static TextStyle get headline1 {
    return _baseTextStyle.copyWith(
      fontSize: 74,
      fontWeight: PuzzleFontWeight.bold,
    );
  }

  static TextStyle get headline2 {
    return _baseTextStyle.copyWith(
      fontSize: 54,
      height: 1.1,
      fontWeight: PuzzleFontWeight.bold,
    );
  }

  static TextStyle get headline3 {
    return _baseTextStyle.copyWith(
      fontSize: 34,
      height: 1.12,
      fontWeight: PuzzleFontWeight.bold,
    );
  }

  static TextStyle get headline3Soft {
    return _baseTextStyle.copyWith(
      fontSize: 34,
      height: 1.17,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  static TextStyle get headline4 {
    return _baseTextStyle.copyWith(
      fontSize: 24,
      height: 1.15,
      fontWeight: PuzzleFontWeight.bold,
    );
  }

  static TextStyle get headline4Soft {
    return _baseTextStyle.copyWith(
      fontSize: 24,
      height: 1.15,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  static TextStyle get headline5 {
    return _baseTextStyle.copyWith(
      fontSize: 16,
      height: 1.25,
      fontWeight: PuzzleFontWeight.bold,
    );
  }

  static TextStyle get bodyLargeBold {
    return _baseTextStyle.copyWith(
      fontSize: 46,
      height: 1.17,
      fontWeight: PuzzleFontWeight.bold,
    );
  }

  static TextStyle get bodyLarge {
    return _baseTextStyle.copyWith(
      fontSize: 46,
      height: 1.17,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  static TextStyle get body {
    return _bodyTextStyle.copyWith(
      fontSize: 24,
      height: 1.33,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  static TextStyle get bodySmall {
    return _bodyTextStyle.copyWith(
      fontSize: 18,
      height: 1.22,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  static TextStyle get bodyXSmall {
    return _bodyTextStyle.copyWith(
      fontSize: 14,
      height: 1.27,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  static TextStyle get label {
    return _baseTextStyle.copyWith(
      fontSize: 14,
      height: 1.27,
      fontWeight: PuzzleFontWeight.regular,
    );
  }

  static TextStyle get countdownTime {
    return _baseTextStyle.copyWith(
      fontSize: 300,
      height: 1,
      fontWeight: PuzzleFontWeight.bold,
    );
  }

  static const _baseTextStyle = TextStyle(
    fontFamily: 'GoogleSans',
    color: PuzzleColors.black,
    fontWeight: PuzzleFontWeight.regular,
  );

  static final _bodyTextStyle = GoogleFonts.roboto(
    color: PuzzleColors.black,
    fontWeight: PuzzleFontWeight.regular,
  );
}
