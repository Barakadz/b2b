import 'package:flutter/material.dart';

import 'package:business/src/ui/widgets/number_widget.dart';
import 'package:get/get.dart';

abstract class KeyboardInterface {
  void onKeyPressed(int type, int key);
}

class KeyboardWidget extends StatefulWidget {
  final KeyboardInterface? listener;
  const KeyboardWidget({super.key, this.listener});

  @override
  State<KeyboardWidget> createState() => KeyboardWidgetState();
}

class KeyboardWidgetState extends State<KeyboardWidget> {
  GlobalKey<NumberWidgetState> sendingButton = GlobalKey();

  void canSend(bool enabled) {
    sendingButton.currentState!.enable(enabled);
  }

  void isLoading(bool loading) {
    sendingButton.currentState!.isLoading(loading);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    double size = Get.width / 5;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: size / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NumberWidget(
                text: '1',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, 1),
              ),
              NumberWidget(
                text: '2',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, 2),
              ),
              NumberWidget(
                text: '3',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, 3),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: size / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NumberWidget(
                text: '4',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, 4),
              ),
              NumberWidget(
                text: '5',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, 5),
              ),
              NumberWidget(
                text: '6',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, 6),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: size / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NumberWidget(
                text: '7',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, 7),
              ),
              NumberWidget(
                text: '8',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, 8),
              ),
              NumberWidget(
                text: '9',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, 9),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: size / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              NumberWidget(
                text: '-2',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, -2),
              ),
              NumberWidget(
                text: '0',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, 0),
              ),
              NumberWidget(
                key: sendingButton,
                text: '-1',
                size: size,
                onTap: () => widget.listener!.onKeyPressed(0, -1),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
