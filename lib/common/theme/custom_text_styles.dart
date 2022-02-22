import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_sliding_puzzle/common/theme/custom_font_weights.dart';

class CustomTextStyles {
  static const _baseTextStyle = TextStyle(
    fontFamily: 'GoogleSans',
    fontWeight: CustomFontWeight.regular,
  );

  static final _bodyTextStyle = GoogleFonts.roboto(
    fontWeight: CustomFontWeight.regular,
  );

  static TextStyle get headline1 {
    return _baseTextStyle.copyWith(
      fontSize: 32,
      height: 1.5,
      fontWeight: CustomFontWeight.bold,
    );
  }

  static TextStyle get headline2 {
    return _baseTextStyle.copyWith(
      fontSize: 24,
      height: 1.33,
      fontWeight: CustomFontWeight.bold,
    );
  }

  static TextStyle get headline3 {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      height: 1.25,
      fontWeight: CustomFontWeight.bold,
    );
  }

  static TextStyle get headline3Soft {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      height: 1.25,
      fontWeight: CustomFontWeight.regular,
    );
  }

  static TextStyle get bodyLargeBold {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      height: 1.5,
      fontWeight: CustomFontWeight.bold,
    );
  }

  static TextStyle get bodyLarge {
    return _baseTextStyle.copyWith(
      fontSize: 18,
      height: 1.5,
      fontWeight: CustomFontWeight.regular,
    );
  }

  static TextStyle get body {
    return _bodyTextStyle.copyWith(
      fontSize: 16,
      height: 1.5,
      fontWeight: CustomFontWeight.regular,
    );
  }

}
