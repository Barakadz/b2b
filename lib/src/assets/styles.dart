import 'package:flutter/material.dart';

class CustomStyles extends ThemeExtension<CustomStyles>{
  final TextStyle? textPlan;
  final TextStyle? textGrey700;
  final TextStyle? textHistory;
  final TextStyle? textDrawerItem;
  final TextStyle? textDrawerSubItem;

  const CustomStyles({
    required this.textPlan,
    required this.textGrey700,
    required this.textHistory,
    required this.textDrawerItem,
    required this.textDrawerSubItem
  });

  @override
  CustomStyles copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  CustomStyles lerp(ThemeExtension<CustomStyles>? other, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }
}