import 'package:business/src/assets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NumberWidget extends StatefulWidget {
  final String? text;
  final double? size;
  final Function() onTap;

  const NumberWidget({super.key, this.text, this.size, required this.onTap});

  @override
  State<NumberWidget> createState() => NumberWidgetState();
}

class NumberWidgetState extends State<NumberWidget> {
  bool _enabled = true;
  bool _pressed = false;
  bool _loading = false;

  void enable(bool enabled) {
    setState(() {
      _enabled = enabled;
    });
  }

  void isLoading(bool loading) {
    setState(() {
      _loading = loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => widget.onTap(),
      onLongPressDown: (details) => onGesture(true, false),
      onLongPressCancel: () => onGesture(false, false),
      onLongPressUp: () => onGesture(false, true),
      child: AnimatedContainer(
        width: widget.size,
        height: widget.size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.size! / 2),
          color: _pressed
              ? CustomColors.zircon.withOpacity(0.4)
              : Colors.transparent,
        ),
        duration: const Duration(milliseconds: 200),
        child: _loading
            ? CircularProgressIndicator(
                color: Get.theme.indicatorColor,
              )
            : widget.text == '-2'
                ? Icon(Icons.backspace, size: widget.size! / 3)
                : widget.text == '-1'
                    ? Icon(Icons.send, size: widget.size! / 3)
                    : Container(
                        height: widget.size,
                        width: widget.size,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(widget.size! / 2),
                          color: _pressed
                              ? Colors.grey.shade400
                              : Colors.transparent,
                        ),
                        child: Text(widget.text!,
                            style: Get.theme.primaryTextTheme.titleMedium
                                ?.copyWith(fontSize: 26)),
                      ),
      ),
    );
  }

  onGesture(bool pressed, bool send) {
    //enabled
    setState(() {
      _pressed = pressed;
      if (send) {
        if (_enabled)
          widget.onTap();
        else
          print("not enabled");
      }
    });
  }
}
