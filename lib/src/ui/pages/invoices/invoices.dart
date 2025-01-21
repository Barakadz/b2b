import 'package:business/src/assets/themes.dart';
import 'package:business/src/controllers/invoices_controller.dart';
import 'package:business/src/controllers/navigation_controller.dart';
import 'package:business/src/models/enums/click_action.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/ui/pages/invoices/widgets/invoices_list.dart';
import 'package:business/src/ui/pages/navigator/widgets/navigation_drawer.dart';
import 'package:business/src/ui/widgets/error_widget.dart';
import 'package:business/src/ui/widgets/progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvoicesPage extends StatelessWidget {
  InvoicesPage({super.key});

  final InvoicesCtrl _controller = Get.put(InvoicesCtrl());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          // toolbarHeight: 90,
          elevation: 0,
          backgroundColor: Get.theme.primaryColor,
          iconTheme: const IconThemeData(color: Colors.white),
          title: Text(
            Get.find<NavigationPageCtrl>().getTitle(NavDrawer.invoicesItem),
            style: Get.theme.primaryTextTheme.bodyMedium
                ?.copyWith(fontSize: 25, fontWeight: FontWeight.w600),
          ),
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                bottom: Radius.elliptical(Get.width, 90.0)),
          ),
        ),
      ),
      drawer: NavDrawer(),
      body: PopScope(
        canPop: false,
        onPopInvoked: (val) =>
            Get.find<NavigationPageCtrl>().setSelectedTab(NavDrawer.homeItem),
        child: GetBuilder<InvoicesCtrl>(
            builder: (ctrl) => RefreshIndicator(
                onRefresh: () async {
                  _controller.fetchData();
                },
                child: Column(
                  children: [
                    _controller.result.status == Status.loading
                        ? const Expanded(
                            child: Center(
                              child: ProgressLoaderWidget(),
                            ),
                          )
                        : _controller.result.status == Status.error
                            ? Expanded(
                                child: Center(
                                  child: SorryWidget(
                                      icon: 'error',
                                      text: 'sorry'.tr,
                                      type: ClickAction.reloadInvoices),
                                ),
                              )
                              //if pas de facture === c'est à dire if sim card is prépaid
                            : _controller.invoices.isEmpty
                                ? Expanded(
                                    child: Center(
                                      child: SorryWidget(
                                          icon: 'empty',
                                          text: 'noInvoices'.tr,
                                          type: ClickAction.reloadInvoices),
                                    ),
                                  )
                                : const Flexible(
                                    child: InvoiceList(),
                                  ),
                    _controller.result.status == Status.success &&
                            _controller.invoices.isNotEmpty
                        ? Container(
                            height: 140,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black26, // shadow color
                                    blurRadius: 10, // shadow radius
                                    offset: Offset(-2, -2), // shadow offset
                                    spreadRadius:
                                        0.0, // The amount the box should be inflated prior to applying the blur
                                    blurStyle:
                                        BlurStyle.normal // set blur style
                                    ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _controller.invoices.isEmpty
                                      ? ''
                                      : '${_controller.totalAmount.toString()} ${'payBefore'.tr} ${_controller.invoices.elementAt(0).toDate.toString().substring(0, 10)}',
                                  style: CommonStyles.itemDesc(
                                      Colors.black, 1, 15),
                                ),
                                const Spacer(),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: TextField(
                                        textAlign: TextAlign.start,
                                        controller: _controller.textController,
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Colors.white.withOpacity(0),
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Get.theme.primaryColor,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(10),
                                                topRight: Radius.circular(10),
                                              ),
                                            ),
                                            hintText: 'amount'.tr,
                                            hintStyle: const TextStyle(
                                                color: Colors.black26)),
                                      ),
                                    ),
                                    const Spacer(),
                                    ElevatedButton(
                                      onPressed: () {
                                        _controller.pay();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red.shade300,
                                      ),
                                      child: Text(
                                        'pay'.tr,
                                        style: CommonStyles.itemDesc(
                                            Colors.white, 1, 16),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
                        : Container(),
                  ],
                ))),
      ),
    );
  }
}
