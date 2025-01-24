import 'package:business/src/assets/colors.dart';
import 'package:business/src/controllers/flexy/flexy_controller.dart';
import 'package:business/src/models/enums/click_action.dart';
import 'package:business/src/models/other/contact.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/ui/pages/flexy/widgets/flexy_dialog.dart';
import 'package:business/src/ui/pages/flexy/widgets/flexy_transaction.dart';
import 'package:business/src/ui/widgets/error_widget.dart';
import 'package:business/src/ui/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexyPage extends StatelessWidget {
  const FlexyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:  PreferredSize(
  preferredSize: const Size.fromHeight(80.0),
  child: AppBar(
    elevation: 0,
    backgroundColor: Colors.transparent, // Make background transparent
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
           CustomColors.secondaryColor,
          CustomColors.primaryColor
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(Get.width, 90.0),
        ),
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    title: Text(
      "flexy".tr,
      style: Get.theme.primaryTextTheme.bodyMedium?.copyWith(
        fontSize: 25, 
        fontWeight: FontWeight.w600,
      ),
    ),
    centerTitle: true,
  ),
)

,
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<FlexyController>(
                init: FlexyController(),
                id: "FlexyList",
                builder: (ctrl) {
                  return RefreshIndicator(
                    onRefresh: () async {
                      ctrl.fetchData();
                    },
                    child: ctrl.result.status == Status.loading
                        ? const Center(
                            child: ProgressLoaderWidget(),
                          )
                        : ctrl.result.status == Status.error
                            ? SorryWidget(
                                icon: 'error',
                                text: 'sorry'.tr,
                                type: ClickAction.reloadTransactions)
                            : ctrl.transactions.isEmpty
                                ? Center(
                                    child: SorryWidget(
                                        icon: 'empty',
                                        text: 'noTransactions'.tr,
                                        type: ClickAction.reloadTransactions),
                                  )
                                : ListView.builder(
                                    itemCount: ctrl.transactions.length,
                                    itemBuilder: (BuildContext context, int i) {
                                      return GestureDetector(
                                          onTap: () => Get.bottomSheet(
                                                FlexyDialog(
                                                  contact: ContactModel(
                                                      name: '',
                                                      number: ctrl.transactions
                                                          .elementAt(i)
                                                          .receiver),
                                                ),
                                                enterBottomSheetDuration:
                                                    const Duration(
                                                        milliseconds: 400),
                                                exitBottomSheetDuration:
                                                    const Duration(
                                                        milliseconds: 400),
                                              ),
                                          child: FlexyTransaction(
                                              transaction: ctrl.transactions
                                                  .elementAt(i)));
                                    },
                                  ),
                  );
                }),
          ),
        ],
      ),
      floatingActionButton: GetBuilder<FlexyController>(
        builder: (ctrl) => FloatingActionButton(
            backgroundColor: CustomColors.secondaryColor,
            foregroundColor: Get.theme.cardColor,
            mini: true,
            onPressed: () => ctrl.openDialog(),
            child: const Icon(Icons.add)),
      ),
    );
  }
}
