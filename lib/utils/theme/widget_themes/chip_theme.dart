import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class TChipTheme {
  TChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: AColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: AColors.black),
    selectedColor: AColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: AColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: AColors.darkerGrey,
    labelStyle: TextStyle(color: AColors.white),
    selectedColor: AColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: AColors.white,
  );
}
