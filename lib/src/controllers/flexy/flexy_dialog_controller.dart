import 'package:business/src/controllers/globale/auth_controller.dart';
import 'package:business/src/helpers/text_helper.dart';
import 'package:business/src/models/dbss/bundle.dart';
import 'package:business/src/models/dbss/package.dart';
import 'package:business/src/models/dbss/product.dart';
import 'package:business/src/models/enums/bundle_type.dart';
import 'package:business/src/models/enums/category.dart';
import 'package:business/src/models/enums/transaction_type.dart';
import 'package:business/src/models/enums/unit.dart';
import 'package:business/src/models/il/Transaction.dart';
import 'package:business/src/models/other/contact.dart';
import 'package:business/src/ui/widgets/dialogs/snake_warning.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:business/src/controllers/base_controller.dart';

class FlexyDialogController extends BaseController {
  double dataAmount = 0;
  String dataUnit = '';
  String dataAmountText = '';
  int contactOption = 0;
  bool validateOption = false;
  List<ContactModel> contacts = [];
  int selectedContact = 0;
  TextEditingController numberController = TextEditingController();
  FocusNode focusNode = FocusNode();
  List<Package>? flexyOffers;
  int selectedPackageIndex = 0;

  @override
  onInit() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
      } else {
        if (TextHelper.isDjezzy(numberController.text, true)) {
          contacts.add(ContactModel(name: '', number: numberController.text));
          selectedContact = 0;
          validateOption = true;
          contactOption = 3;
          update();
        } else {
          SnackBarInfo.snackAlert('Warning',
              'Please, enter a valid Djezzy number.', Alerts.warning);
          focusNode.requestFocus();
        }
      }
    });
    dataAmountToText();
    super.onInit();
  }

  initContact() {
    contactOption = 0;
    validateOption = false;
    selectedContact = 0;
    contacts = [];
    update();
  }

  dataAmountToText() {
    Bundle? bundle = Package.getBundle(BundleType.data,
        getDataOffers().elementAt(selectedPackageIndex).bundles);
    if (bundle != null) {
      dataUnit = bundle.usageUnit!.format();
      dataAmount = bundle.amount!;
      dataAmountText = '${bundle.amount.toString()} $dataUnit';
    }
    update();
  }

  decrement() {
    if (selectedPackageIndex > 0) {
      selectedPackageIndex--;
      dataAmountToText();
    }
  }

  increment() {
    if (selectedPackageIndex < getDataOffers().length - 1) {
      selectedPackageIndex++;
      dataAmountToText();
    }
  }

  setContactOption(int sel) {
    contactOption = sel;
    update();
  }

  setValidateOption(bool val) {
    validateOption = val;
    update();
  }

  setSelectedContact(int i) {
    selectedContact = i;
    update();
  }

  Transaction getTransaction() {
    Transaction t = Transaction(
        type: TransactionType.data.name,
        amount: dataAmount.toInt().toString(),
        pin: null,
        receiver: TextHelper.internationalFormat(
            contacts.elementAt(selectedContact).number!),
        code: flexyOffers!.elementAt(selectedPackageIndex).code);
        print("|");
        print("|");
        print("|");
        print("|");
        print("|");
        print("|");
        print("|");
        print("transaction ====================================================>$t");
        print("|");
        print("|");
        print("|");
        print("|");
        print("|");
        print("|");
        print("|");
    return t;
  }

  List<Package> getDataOffers() {
    if (flexyOffers == null) loadFlexyOffers();
    return flexyOffers!;
  }

  void loadFlexyOffers() {
    flexyOffers = [];

    List<Product> products = Get.find<AuthController>().services;
    for (int i = 0; i < products.length; i++) {
      if (products.elementAt(i).category == Category.flexy) {
        flexyOffers = products.elementAt(i).packs;
      }
    }
    if (flexyOffers!.isNotEmpty) {
      flexyOffers!.sort((a, b) {
        return a.order!.compareTo(b.order!);
      });
    }
  }

  @override
  void onClose() {
    focusNode.dispose();
    super.onClose();
  }
}
