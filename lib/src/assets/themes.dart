import 'package:flutter/material.dart';

import 'package:business/src/assets/colors.dart';
import 'package:business/src/assets/styles.dart';

abstract class CommonStyles {
  static const TextStyle groupTitle = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600);

  static const TextStyle internalLink = TextStyle(
      fontFamily: 'Roihu',
      color: Color(0xFFED576A),
      fontSize: 14,
      fontWeight: FontWeight.w600);

  static TextStyle itemTitleBlack(Color color, double height) {
    return TextStyle(
        height: height,
        fontFamily: 'Roihu',
        color: color,
        fontSize: 13,
        fontWeight: FontWeight.w600);
  }

  static TextStyle itemDesc(Color color, double height, double fontSize) {
    return TextStyle(
        height: height,
        fontFamily: 'Roihu',
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w600);
  }

  static TextStyle itemDescLight(Color color, double height, double fontSize) {
    return TextStyle(
      height: height,
      fontFamily: 'Roihu',
      color: color,
      fontSize: fontSize,
    );
  }

  static const TextStyle itemTitleWhite = TextStyle(
      height: 2,
      fontFamily: 'Roihu',
      color: Colors.white,
      fontSize: 15,
      fontWeight: FontWeight.w600);

  static const TextStyle itemSubTitleBlack = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.black54,
      fontSize: 13,
      fontWeight: FontWeight.w600);

  static const TextStyle itemSubTitleWhite = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.white38,
      fontSize: 13,
      fontWeight: FontWeight.w600);

  static const TextStyle pubTypeSliderTextWhite = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.w900);

  static const TextStyle pubTypeSliderTextBlack = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.w900);

  static const TextStyle textGrey700Light = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.grey,
      fontSize: 16,
      fontWeight: FontWeight.w400);

  static const TextStyle textBlue = TextStyle(
      fontFamily: 'Roihu',
      color: blue02,
      fontSize: 14,
      fontWeight: FontWeight.w400);

  static const TextStyle textBlueDark = TextStyle(
      fontFamily: 'Roihu',
      color: blue01,
      fontSize: 14,
      fontWeight: FontWeight.w400);

  static const TextStyle textBlack = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.w400);

  static const TextStyle textWhite = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.white70,
      fontSize: 14,
      fontWeight: FontWeight.w400);

  static const TextStyle textHugeBlack1 = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w900);

  static const TextStyle textHugeWhite1 = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.white70,
      fontSize: 20,
      fontWeight: FontWeight.w900);

  static const TextStyle textHugeBlack2 = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w900);

  static const TextStyle textHugeWhite2 = TextStyle(
      fontFamily: 'Roihu',
      color: Colors.white70,
      fontSize: 20,
      fontWeight: FontWeight.w900);

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      fontFamily: 'Roihu',
      primaryColor: isDarkTheme ? Colors.white : Colors.black54,
      indicatorColor:
          isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      hintColor:
          isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),
      highlightColor:
          isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor: Color(isDarkTheme ? 0xff3A3A3B : 0xff4285F4),
      focusColor:
          isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
      colorScheme: ColorScheme.fromSwatch(
              primarySwatch: getMaterialColor(const Color(0xFFED576A)))
          .copyWith(
              background: isDarkTheme ? Colors.black : const Color(0xffF1F5FB)),
    ).copyWith(
      extensions: <ThemeExtension<dynamic>>[
        CustomColors(
          statusBar: const Color(0xFFAB2328),
          controlsColor: blue03,
          doneStatusPrimary: isDarkTheme ? Colors.white54 : color17,
          doneStatusSecondary: isDarkTheme ? Colors.white24 : color8,
          doneStatusGreen: isDarkTheme ? green01 : color13,
          doneStatusGreenBis: isDarkTheme ? Colors.white70 : color4,
          cardDefault: isDarkTheme
              ? const Color.fromARGB(179, 169, 199, 162)
              : const Color.fromARGB(179, 169, 199, 162),
          tabIcons: isDarkTheme ? Colors.white70 : Colors.white70,
          backgroundBottomTabs: isDarkTheme
              ? const Color.fromARGB(255, 100, 99, 99)
              : Colors.white,
          profileBG: const Color(0xFFED576A),
          //isDarkTheme ? Color(0xFFED576A) : Color(0xFFDA291C),
          backgroundPubs:
              isDarkTheme ? const Color(0xFFCFD8DC) : Colors.blueGrey[100],
        ),
        CustomStyles(
            textGrey700: isDarkTheme ? textGrey700Light : textGrey700Light,
            textHistory: isDarkTheme ? textBlueDark : textBlue,
            textPlan: isDarkTheme ? textWhite : textBlack,
            textDrawerItem: isDarkTheme
                ? itemTitleWhite
                : itemTitleBlack(Colors.black, 1.5),
            textDrawerSubItem:
                isDarkTheme ? itemSubTitleWhite : itemSubTitleBlack),
      ],
    );
  }

  static const Color green01 = Color.fromARGB(0xFF, 0x82, 0xCD, 0x47);
  static const Color green02 = Color.fromARGB(0xFF, 0x54, 0xB4, 0x35);
  static const Color green03 = Color.fromARGB(0xFF, 0x37, 0x92, 0x37);
  static List<Color> trainingPlanPalette = [green01, green02, green03];

  static const Color blue02 = Color.fromARGB(0xFF, 0x41, 0x72, 0x9F);
  static const Color blue01 = Color.fromARGB(0xFF, 0x58, 0x85, 0xAF);
  static const Color blue03 = Color.fromARGB(0xFF, 0x27, 0x44, 0x72);
  static List<Color> trainingPalette = [blue01, blue02, blue03];

  //Static Colors
  static Color color4 = const Color(0xFF00BF6F);
  static Color color13 = const Color(0x5500BF6F);
  static Color color8 = const Color(0xFF307FE2);
  static Color color17 = const Color(0x55307FE2);

  static Color color1 = const Color(0xFFFFB81C);
  static Color color2 = const Color(0xFFF65275);
  static Color color3 = const Color(0xFFE10098);

  static Color color5 = const Color(0xFFD0DF00);
  static Color color6 = const Color(0xFFFFD700);
  static Color color7 = const Color(0xFF9063CD);
  static Color color9 = const Color(0xFF2DCCD3);
  static Color color10 = const Color(0xAAFFB81C);
  static Color color11 = const Color(0xAAF65275);
  static Color color12 = const Color(0xAAE10098);
  static Color color14 = const Color(0xAAD0DF00);
  static Color color15 = const Color(0xAAFFD700);
  static Color color16 = const Color(0xAA9063CD);
  static Color color18 = const Color(0xAA2DCCD3);

  static List<Color> chartPalette = [
    color1,
    color2,
    color3,
    color4,
    color5,
    color6,
    color7,
    color8,
    color9,
    color10,
    color11,
    color12,
    color13,
    color14,
    color15,
    color16,
    color17,
    color18
  ];

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };
    return MaterialColor(color.value, shades);
  }
}
