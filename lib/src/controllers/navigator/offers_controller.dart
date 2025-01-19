
import 'package:get/get.dart';
import 'package:flutter/widgets.dart';

import 'package:business/src/models/dbss/product.dart';
import 'package:business/src/models/dbss/package.dart';
import 'package:business/src/models/response/pair.dart';
import 'package:business/src/models/enums/category.dart';

import 'package:business/src/services/api/api.dart';
import 'package:business/src/controllers/base_controller.dart';
import 'package:business/src/repositories/user_repository.dart';

class OffersController extends BaseController {

  var offerType = Category.mixed;
  var products = <Product>[].obs;

  var selected = 0;

  late FixedExtentScrollController listController;

  @override
  onInit() {
    listController = FixedExtentScrollController();
    super.onInit();
  }

  reload(bool force) async {
    if(result.status == Status.loading || (products.isNotEmpty && !force)) {
      return;
    }

    //Set status to starting
    updateStatus(Pair(Status.loading, Reason.idle));

    //Reload Data
    var tmp = await UserRepository.getInfo(null, [Api.illegibilityVal]);
    var count = (tmp?.includes ?? []).length;

    //Add items
    products.value = <Product>[];
    for (var i = 0; i < count; i++) {
      if (tmp!.includes?[i].type == Api.illegibilityVal) {
        var product = tmp.includes?[i] as Product;
        if (product.category != Category.none &&
            product.category != Category.flexy &&
            product.category != Category.loan) {
          products.add(tmp.includes?[i] as Product);
        }
      }
    }

    //Update interface
    update(["OffersList"]);

    //Selected
    updatePosition(selected);

    //Set status to not starting
    Future.delayed(const Duration(milliseconds: 200), () {
      if (products.length > 1) {
        listController.animateToItem(1,
            duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
      }
    });
  }

  activate(Package? package) async {
    updateStatus(Pair(Status.starting, Reason.idle));

    //Reload Data
    var response = await UserRepository.activate(this, package?.code);

    //Check response
    if(response?.status == 200){
      updateStatus(Pair(Status.success, Reason.idle));
    }else{
      updateStatus(Pair(Status.error, Reason.unknown));
    }
  }

  generateError(Pair error) {
    updateStatus(error);
    update();
  }

  updatePosition(int pos) {
    selected = pos;
    update(["selected"]);
  }


  @override
  void onClose() {
    listController.dispose();
    super.onClose();
  }
}
