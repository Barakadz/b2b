
import 'package:flutter/material.dart';

extension ThemeModeEx on ThemeMode {

  static ThemeMode get(String? value) {
    try {
      return ThemeMode.values.byName(value ?? "");
    } catch (e) {
      return ThemeMode.system;
    }
  }
}