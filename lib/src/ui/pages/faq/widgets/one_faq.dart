import 'package:business/src/models/other/faq.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqOneitem extends StatelessWidget {
  const FaqOneitem({super.key, this.item});
  final FaqModel? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey)],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: ExpansionTile(
        title: Text(
          item!.question!.getValue(),
          style:
              Get.theme.primaryTextTheme.displayMedium?.copyWith(fontSize: 14),
        ),
        shape: const BeveledRectangleBorder(
            side: BorderSide(
          style: BorderStyle.none,
        )),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              item!.answer!.getValue(),
              style: Get.theme.textTheme.bodyMedium
                  ?.copyWith(fontSize: 13, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
