import 'package:flutter/material.dart';

class CustomColors extends ThemeExtension<CustomColors> {

  static Color tuna = const Color(0xFF333644);
  static Color zircon = const Color(0xFFFAFCFF);
  static Color paleSky = const Color(0xFF6A737C);
  static Color alizarin = const Color(0xFFE71F38);
  static Color mineShaft = const Color(0xFF333333);
  static Color grayChateau = const Color(0xFFA2AAAD);

  final Color? doneStatusPrimary;
  final Color? doneStatusSecondary;
  final Color? doneStatusGreen;
  final Color? doneStatusGreenBis;
  final Color? cardDefault;
  final Color? backgroundBottomTabs;
  final Color? tabIcons;
  final Color? statusBar;
  final Color? profileBG;
  final Color? controlsColor;
  final Color? backgroundPubs;

  const CustomColors(
      {required this.doneStatusPrimary,
        required this.doneStatusSecondary,
        required this.doneStatusGreen,
        required this.doneStatusGreenBis,
        required this.tabIcons,
        required this.backgroundBottomTabs,
        required this.statusBar,
        required this.cardDefault,
        required this.profileBG,
        required this.controlsColor,
        required this.backgroundPubs});

  @override
  CustomColors copyWith() {
    throw UnimplementedError();
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    throw UnimplementedError();
  }
}