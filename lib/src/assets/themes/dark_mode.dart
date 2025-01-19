
import 'package:business/src/assets/colors.dart';
import 'package:flutter/material.dart';

abstract class DarkTheme {

  static ThemeData get() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'OpenSans',
      brightness: Brightness.dark,

      dividerColor: CustomColors.grayChateau,
      cardColor: CustomColors.mineShaft,
      indicatorColor: CustomColors.zircon,
      primaryColor: CustomColors.mineShaft,
      shadowColor: CustomColors.grayChateau,
      scaffoldBackgroundColor: CustomColors.tuna,
      primaryColorDark: CustomColors.mineShaft,
      primaryColorLight: CustomColors.alizarin,

      primaryTextTheme: TextTheme(
        displayLarge: TextStyle(color: CustomColors.grayChateau, fontWeight: FontWeight.w600),
        displaySmall: TextStyle(color: CustomColors.grayChateau, fontWeight: FontWeight.w600),
        displayMedium: TextStyle(color: CustomColors.grayChateau, fontWeight: FontWeight.w600, fontSize: 16),

        titleMedium: TextStyle(color: CustomColors.zircon, fontWeight: FontWeight.w600, fontSize: 18),
        titleSmall: TextStyle(color: CustomColors.zircon, fontWeight: FontWeight.w400, fontSize: 11),

        bodyMedium: TextStyle(color: CustomColors.zircon, fontWeight: FontWeight.w700, fontSize: 15),
        bodySmall: TextStyle(color: CustomColors.zircon, fontWeight: FontWeight.w600, fontSize: 14),
      ),

      tabBarTheme: TabBarTheme(
        labelColor: CustomColors.zircon,
        dividerColor: CustomColors.tuna,
        indicatorColor: CustomColors.alizarin,
        unselectedLabelColor: CustomColors.paleSky,
        labelStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
      ),

      drawerTheme: DrawerThemeData(
        backgroundColor: CustomColors.mineShaft,
      ),

      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        selectedColor: CustomColors.zircon,
        iconColor: CustomColors.grayChateau,
        textColor: CustomColors.grayChateau,
        titleTextStyle: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
      ),

      dialogTheme: DialogTheme(
        backgroundColor: CustomColors.mineShaft,
      ),

      //For dialogs
      textTheme: TextTheme(

        //Dialog Title (ex: offer name)
        titleLarge: TextStyle(color: CustomColors.grayChateau, fontWeight: FontWeight.w700, fontSize: 20),
        titleMedium: TextStyle(color: CustomColors.grayChateau, fontWeight: FontWeight.w600, fontSize: 18),

        //Bundle quota/type in red (Primary)
        headlineMedium: TextStyle(color: CustomColors.grayChateau, fontSize: 16, fontWeight: FontWeight.w700),
        headlineSmall: TextStyle(color: CustomColors.grayChateau, fontSize: 15, fontWeight: FontWeight.w600),

        //Bundle quota/type in gray (Secondary)
        labelMedium: TextStyle(color: CustomColors.grayChateau, fontSize: 15, fontWeight: FontWeight.w700),
        labelSmall: TextStyle(color: CustomColors.grayChateau, fontSize: 14, fontWeight: FontWeight.w600),

        //labelLarge: ,
        //labelMedium: ,
        //bodyLarge: ,

        displayLarge: TextStyle(color: CustomColors.grayChateau, fontWeight: FontWeight.w600),
        displaySmall: TextStyle(color: CustomColors.grayChateau, fontWeight: FontWeight.w600),
        displayMedium: TextStyle(color: CustomColors.grayChateau, fontWeight: FontWeight.w600, fontSize: 16),
      ),

    );
  }
}