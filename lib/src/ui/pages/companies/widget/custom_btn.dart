import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Color? textColor;
  final Color? backgroundColor;
  final double height;
  final void Function() onTab;
  final bool isEnabled;
  final disabledColor = Colors.blueGrey[400];

  CustomBtn({
    Key? key,
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.height,
    required this.onTab,
    required this.isEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnabled ? onTab : null,
      child: Container(
        padding: const EdgeInsets.all(10),
        height: height,
        decoration: BoxDecoration(
          color: isEnabled
              ? backgroundColor
              : disabledColor ?? backgroundColor?.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: textColor?.withOpacity(
                isEnabled ? 1.0 : 0.4,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
