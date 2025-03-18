import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class TElevatedButtonTheme {
  TElevatedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AColors.light,
      backgroundColor: AColors.primary,
      disabledForegroundColor: AColors.darkGrey,
      disabledBackgroundColor: AColors.buttonDisabled,
      side: const BorderSide(color: AColors.primary),
      padding: const EdgeInsets.symmetric(vertical: ASizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: AColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ASizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: AColors.light,
      backgroundColor: AColors.primary,
      disabledForegroundColor: AColors.darkGrey,
      disabledBackgroundColor: AColors.darkerGrey,
      side: const BorderSide(color: AColors.primary),
      padding: const EdgeInsets.symmetric(vertical: ASizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: AColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ASizes.buttonRadius)),
    ),
  );
}
