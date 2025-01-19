import 'package:business/src/controllers/faq_controller.dart';
import 'package:business/src/models/enums/click_action.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/ui/pages/faq/widgets/one_faq.dart';
import 'package:business/src/ui/widgets/error_widget.dart';
import 'package:business/src/ui/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaqList extends StatelessWidget {
  const FaqList({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FaqController>(
      builder: (ctrl) => ctrl.result.status == Status.loading
          ? const Center(
              child: ProgressLoaderWidget(),
            )
          : ctrl.result.status == Status.error
              ? SorryWidget(
                  icon: 'error', text: 'sorry'.tr, type: ClickAction.reloadFaq)
              : Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          controller: ctrl.scrollController,
                          itemCount: ctrl.faqs.length,
                          itemBuilder: (context, index) => GestureDetector(
                              onTap: () => {},
                              child: FaqOneitem(item: ctrl.faqs[index])),
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
    );
  }
}
