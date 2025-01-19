import 'package:business/src/controllers/flexy/flexy_dialog_controller.dart';
import 'package:business/src/models/other/contact.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlexyDialog extends StatelessWidget {
  const FlexyDialog({super.key, this.contact});
  final ContactModel? contact;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<FlexyDialogController>(
      init: FlexyDialogController(),
      builder: (ctrl) => Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
            color: Get.theme.dialogTheme.backgroundColor,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0))),
        child: Wrap(
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 200),
              reverseDuration: const Duration(milliseconds: 100),
              child: Container(
                color: Colors.transparent,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'dataToSend'.tr,
                      style: Get.theme.primaryTextTheme.displayMedium
                          ?.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text(
                          ctrl.dataAmountText,
                          style: Get.theme.textTheme.headlineLarge
                              ?.copyWith(fontSize: 20),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () => ctrl.decrement(),
                          child: const Icon(Icons.remove),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        ElevatedButton(
                          onPressed: () => ctrl.increment(),
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'forWhom'.tr,
                      style: Get.theme.primaryTextTheme.displayMedium
                          ?.copyWith(fontSize: 14),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: ctrl.contactOption == 1
                          ? Container()
                          : ctrl.contactOption == 2
                              ? TextField(
                                  autofocus: true,
                                  focusNode: ctrl.focusNode,
                                  textAlign: TextAlign.center,
                                  controller: ctrl.numberController,
                                  maxLength: 10,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white.withOpacity(0),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Get.theme.dividerColor,
                                          width: 1),
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    hintText: 'number'.tr,
                                    hintStyle:
                                        const TextStyle(color: Colors.black26),
                                  ),
                                )
                              : ctrl.contactOption == 3 || contact != null
                                  ? Container()
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () => {},
                                          child: Column(
                                            children: [
                                              Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Get.theme.shadowColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: const Icon(Icons
                                                      .contact_phone_outlined)),
                                              Text(
                                                'myContacts'.tr,
                                                style: Get
                                                    .theme.textTheme.bodyMedium
                                                    ?.copyWith(fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            ctrl.setContactOption(2);
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                    color:
                                                        Get.theme.shadowColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30),
                                                  ),
                                                  child: const Icon(Icons
                                                      .keyboard_alt_outlined)),
                                              Text(
                                                'typeNumber'.tr,
                                                style: Get
                                                    .theme.textTheme.bodyMedium
                                                    ?.copyWith(fontSize: 12),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                    ),
                    if (ctrl.validateOption || contact != null)
                      Container(
                        height: 70,
                        width: Get.width,
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  contact != null ? 1 : ctrl.contacts.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                child: GestureDetector(
                                  onTap: () => ctrl.setSelectedContact(index),
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: contact != null
                                            ? Get.theme.primaryColor
                                            : ctrl.selectedContact == index
                                                ? Get.theme.primaryColor
                                                : Get.theme.disabledColor,
                                      ),
                                      Text(contact != null
                                          ? contact!.number!
                                          : ctrl.contacts[index].number!)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            if (contact == null)
                              Positioned(
                                right: 10,
                                top: 10,
                                child: GestureDetector(
                                  onTap: () => ctrl.initContact(),
                                  child: const Icon(Icons.cancel),
                                ),
                              ),
                          ],
                        ),
                      ),
                    if (ctrl.validateOption || contact != null)
                      Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Get.back(result: 0);
                              },
                              child: const Icon(Icons.arrow_back_ios),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  ctrl.contacts.add(contact!);
                                  Get.back(result: ctrl.getTransaction());
                                },
                                child: Text(
                                  'confirm'.tr,
                                  style: Get.theme.primaryTextTheme.titleMedium
                                      ?.copyWith(fontSize: 16),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
