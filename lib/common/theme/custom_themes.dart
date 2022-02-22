import 'package:flutter/material.dart';

import 'custom_colors.dart';
import 'custom_text_styles.dart';

class CustomThemes {
  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: CustomColors.primary,
      textTheme: TextTheme(
        headline1: CustomTextStyles.headline1,
        headline2: CustomTextStyles.headline2,
        headline3: CustomTextStyles.headline3,
        bodyText1: CustomTextStyles.bodyLargeBold,
        bodyText2: CustomTextStyles.body,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          primary: CustomColors.primary,
          backgroundColor: CustomColors.elevatedButtonBg,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          primary: CustomColors.outlineButton,
        ),
      ),
    );
  }
}
