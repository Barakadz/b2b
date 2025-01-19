
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

  const DialogFooter({
    super.key,
    this.parent,
    this.listener,
    this.positive,
    this.neutral,
    this.negative,
  });

  @override
  Widget build(Object context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 100),
          child: Divider(),
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _addButtons()
        )
      ],
    );
  }

  List<Widget> _addButtons(){

    ///Init widgets list
    List<Widget> widgets = [];

    ///Add Cancel button
    if(negative != null){
      widgets.add(
        TextButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(negative ?? ""),
          ),
          onPressed: () => listener?.onClick(parent, ClickType.negative),
        ),
      );
    }

    ///Add neutral button
    if(neutral != null){
      widgets.add(
        TextButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(neutral ?? ""),
          ),
          onPressed: () => listener?.onClick(parent, ClickType.neutral),
        ),
      );
    }

    ///Add positive button
    if(positive != null){
      widgets.add(
        TextButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Text(positive ?? ""),
          ),
          onPressed: () => listener?.onClick(parent, ClickType.positive),
        ),
      );
    }

    ///Return widgets list
    return widgets;
  }
}