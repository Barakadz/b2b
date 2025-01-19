import 'dart:math';

import 'package:business/src/models/dbss/balance.dart';
import 'package:business/src/models/enums/bundle_type.dart';
import 'package:business/src/models/enums/unit.dart';
import 'package:intl/intl.dart';

class TextHelper {
  static var randomFormat = "yyyy-MM-dd";
  static var iso8601Format = "yyyy-MM-ddThh:mm:ss";
  static String shortDateFormat = 'dd MMM yyyy';

  static var internationalMask = "213XXXXXXXXX";
  static var phoneNumberRegex = "^(0|213)[0-9]*";

  static var displayInterMask = "2137 XX XX XX XX";
  static var displayNationalMask = "0X XX XX XX XX";

  static var nationalDefMask = "XX XX XX XX XX";
  static var interDefMask = "XXX XXX XXX XXX";

  static String format(String? str, {String? format}) {
    if (str == null || str == "") return "";

    //Retrieve mask
    var mask =
        format ?? (str.startsWith("2137") ? interDefMask : nationalDefMask);
    str.split("").forEach((item) => mask = mask.replaceFirst('X', item));
    return mask.replaceAll('X', "");
  }

  static String internationalFormat(String number) {
    if (number.length < 9) {
      return "";
    }
    String brut = number.replaceAll(" ", "");
    brut = brut.substring(brut.length - 9);
    return format(brut, format: internationalMask);
  }

  static String nationalFormat(String? number) {
    if (number == null || number.length < 9) {
      return "";
    }
    String brut = number.replaceAll(" ", "");
    brut = brut.substring(brut.length - 9);
    return format(brut, format: displayNationalMask);
  }

  static bool isDjezzy(String str, bool checkLength) {
    var cleanedStr = str.replaceAll(RegExp(r'\D'), '');
    if (checkLength) {
      return (cleanedStr.startsWith('2137') && cleanedStr.length == 12) ||
          (cleanedStr.startsWith('07') && cleanedStr.length == 10);
    } else {
      return cleanedStr.startsWith(phoneNumberRegex);
    }
  }

  static String getDigits(String str) {
    return str.replaceAll(RegExp(r'\D'), '');
  }

  static double? getDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return 0;
  }

  static String doubleToCeil(double? value) {
    if (value == null) return '';
    return value.toInt().toString();
  }

  static String roundDouble(double value, int places) {
    if (places == 0) {
      return value.toInt().toString();
    } else {
      double mod = pow(10.0, places) as double;
      return ((value * mod).round().toDouble() / mod).toString();
    }
  }

  static String balanceToText(Balance balance) {
    String unit = balance.unit!.format();
    double remaining = balance.remaining!;
    String remainingDisplay = doubleToCeil(remaining);
    if (balance.type == BundleType.data) {
      if (unit.isEmpty) {
        if (remaining >= 1024) {
          if (remaining == balance.total) {
            remainingDisplay = roundDouble(remaining / 1024, 0);
          } else {
            remainingDisplay = roundDouble(remaining / 1024, 2);
          }
          unit = Unit.gb.format();
        } else {
          unit = Unit.mb.format();
          remainingDisplay = roundDouble(remaining, 0);
        }
      }
    }
    return '$remainingDisplay $unit';
  }

  static String DateToDisplay(String date, String format) {
    DateTime dt = DateTime.parse(date);
    int year = dt.year;
    if (year == 9999) return '';
    return DateFormat(format).format(dt);
  }

  static DateTime? getDate(dynamic value, String format) {
    try {
      return DateFormat(format).parse(value);
    } catch (ex) {}
    return null;
  }
}
