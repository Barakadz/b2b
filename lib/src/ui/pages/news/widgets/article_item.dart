import 'package:business/src/models/other/news/article.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleItem extends StatelessWidget {
  const ArticleItem({super.key, this.item});
  final Article? item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        /*gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [
            Color.fromARGB(255, 234, 221, 255),
            Color.fromARGB(255, 255, 255, 255),
          ],
        ),*/
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        boxShadow: const [
          BoxShadow(
              blurRadius: 5,
              spreadRadius: 0.0,
              offset: Offset(1, 1),
              color: Colors.black26,
              blurStyle: BlurStyle.normal),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/factory3.png',
            height: 120,
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10, top: 10),
            child: Text(
              item!.title!,
              style: Get.theme.primaryTextTheme.displayMedium
                  ?.copyWith(fontSize: 17),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              item!.description!,
              style: Get.theme.primaryTextTheme.displayMedium
                  ?.copyWith(fontSize: 15),
              textAlign: TextAlign.center,
            ),
          ),
          Row(
            children: [
              const Spacer(),
              GestureDetector(
                onTap: () {
                  /*Get.to(ArticleDetail(
                    id: item,
                  ));*/
                },
                child: Text(
                  'more'.tr,
                  style:
                      Get.theme.textTheme.labelMedium?.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
