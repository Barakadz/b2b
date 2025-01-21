import 'package:flutter/material.dart';

enum ClickType {
  positive,
  negative,
  neutral,
}

abstract class DialogInterface {
  void onClick(Key? key, ClickType clickType);
}

class DialogFooter extends StatelessWidget {
  final Key? parent;
  final DialogInterface? listener;
  final String? negative;
  final String? neutral;
  final String? positive;
  final Color positiveColor;
  final Color negativeColor;
  final Color neutralColor;
  final double elevation;
  final double borderRadius;
  final EdgeInsets buttonPadding;

  const DialogFooter({
    super.key,
    this.parent,
    this.listener,
    this.positive,
    this.neutral,
    this.negative,
    this.positiveColor = Colors.green,
    this.negativeColor = Colors.red,
    this.neutralColor = Colors.blue,
    this.elevation = 3.0,
    this.borderRadius = 12.0,
    this.buttonPadding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
         
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
          children: _buildButtons(context),
        ),
      ],
    );
  }

  List<Widget> _buildButtons(BuildContext context) {
    final TextStyle buttonTextStyle = Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold);

    Widget createStyledButton({
      required String text,
      required ClickType type,
      required Color color,
      required IconData icon,
      bool isOutlined = false,
    }) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: isOutlined
            ? OutlinedButton.icon(
                onPressed: () => listener?.onClick(parent, type),
                icon: Icon(icon, color: color),
                label: Text(text, style: buttonTextStyle.copyWith(color: color)),
                style: OutlinedButton.styleFrom(
                  padding: buttonPadding,
                  side: BorderSide(color: color),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              )
            : ElevatedButton.icon(
                onPressed: () => listener?.onClick(parent, type),
                icon: Icon(icon, color: Colors.white),
                label: Text(text, style: buttonTextStyle.copyWith(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: color,
                  elevation: elevation,
                  padding: buttonPadding,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
      );
    }

    final List<Widget> buttons = [];

    if (negative != null) {
      buttons.add(createStyledButton(
        text: negative!,
        type: ClickType.negative,
        color: negativeColor,
        icon: Icons.cancel,
        isOutlined: true,
      ));
    }

    if (neutral != null) {
      buttons.add(createStyledButton(
        text: neutral!,
        type: ClickType.neutral,
        color: neutralColor,
        icon: Icons.info,
        isOutlined: true,
      ));
    }

    if (positive != null) {
      buttons.add(createStyledButton(
        text: positive!,
        type: ClickType.positive,
        color: positiveColor,
        icon: Icons.check_circle,
      ));
    }

    return buttons;
  }
}
