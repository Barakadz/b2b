import 'package:flutter/material.dart';
import 'package:business/src/assets/colors.dart';

abstract class LightTheme {
  static ThemeData get() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'OpenSans',
      brightness: Brightness.light,
      cardColor: CustomColors.zircon,
      primaryColor: CustomColors.alizarin,
      dividerColor: CustomColors.mineShaft,
      indicatorColor: CustomColors.alizarin,
      shadowColor: CustomColors.grayChateau,
      scaffoldBackgroundColor: Colors.white,
      primaryColorDark: CustomColors.mineShaft,
      primaryColorLight: CustomColors.alizarin,
      colorScheme: ColorScheme.light(
        primary: CustomColors
            .alizarin, // This color will be used by the RefreshIndicator
      ),
      primaryTextTheme: TextTheme(
        displayLarge:
            TextStyle(color: CustomColors.zircon, fontWeight: FontWeight.w600),
        displaySmall: TextStyle(
            color: CustomColors.grayChateau, fontWeight: FontWeight.w600),
        displayMedium: TextStyle(
            color: CustomColors.mineShaft,
            fontWeight: FontWeight.w600,
            fontSize: 16),
        titleMedium: TextStyle(
            color: CustomColors.mineShaft,
            fontWeight: FontWeight.w600,
            fontSize: 18),
        titleSmall: TextStyle(
            color: CustomColors.mineShaft,
            fontWeight: FontWeight.w400,
            fontSize: 11),
        bodyMedium: TextStyle(
            color: CustomColors.zircon,
            fontWeight: FontWeight.w700,
            fontSize: 15),
        bodySmall: TextStyle(
            color: CustomColors.zircon,
            fontWeight: FontWeight.w600,
            fontSize: 14),
      ),
      tabBarTheme: TabBarTheme(
        dividerColor: CustomColors.zircon,
        labelColor: CustomColors.alizarin,
        indicatorColor: CustomColors.alizarin,
        unselectedLabelColor: CustomColors.paleSky,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        unselectedLabelStyle:
            const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: CustomColors.zircon,
      ),
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        iconColor: CustomColors.grayChateau,
        textColor: CustomColors.grayChateau,
        selectedColor: CustomColors.mineShaft,
        titleTextStyle:
            const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: CustomColors.zircon,
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
            color: CustomColors.mineShaft,
            fontWeight: FontWeight.w700,
            fontSize: 20),
        titleMedium: TextStyle(
            color: CustomColors.mineShaft,
            fontWeight: FontWeight.w600,
            fontSize: 18),
        headlineMedium: TextStyle(
            color: CustomColors.alizarin,
            fontWeight: FontWeight.w700,
            fontSize: 16),
        labelMedium: TextStyle(
            color: CustomColors.alizarin,
            fontWeight: FontWeight.w600,
            fontSize: 15),
        headlineSmall: TextStyle(
            color: CustomColors.mineShaft,
            fontWeight: FontWeight.w700,
            fontSize: 15),
        labelSmall: TextStyle(
            color: CustomColors.mineShaft,
            fontWeight: FontWeight.w600,
            fontSize: 14),
        displayLarge:
            TextStyle(color: CustomColors.zircon, fontWeight: FontWeight.w600),
        displaySmall:
            TextStyle(color: CustomColors.zircon, fontWeight: FontWeight.w600),
        displayMedium: TextStyle(
            color: CustomColors.zircon,
            fontWeight: FontWeight.w600,
            fontSize: 16),
      ),
    );
  }
}
