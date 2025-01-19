import 'package:business/src/controllers/news/news_controller.dart';
import 'package:business/src/models/enums/click_action.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/ui/pages/news/widgets/article_item.dart';
import 'package:business/src/ui/widgets/error_widget.dart';
import 'package:business/src/ui/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticlesList extends StatelessWidget {
  const ArticlesList({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NewsController>(
      id: 'loader',
      builder: (ctrl) => ctrl.result.status == Status.loading
          ? const Center(
              child: ProgressLoaderWidget(),
            )
          : ctrl.result.status == Status.error
              ? const SorryWidget(
                  icon: 'error',
                  text: 'Sorry, try again',
                  type: ClickAction.reloadCompanies)
              : Scaffold(
                  body: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            controller: ctrl.scrollController,
                            itemCount: ctrl.articlesList.length,
                            itemBuilder: (context, index) => GestureDetector(
                                onTap: () => {},
                                child: ArticleItem(
                                    item: ctrl.articlesList[index])),
                          ),
                        ),
                        if (ctrl.isFetching)
                          const Padding(
                            padding: EdgeInsets.only(top: 10, bottom: 40),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
