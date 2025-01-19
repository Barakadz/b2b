import 'dart:io';
import 'package:business/src/controllers/base_controller.dart';
import 'package:business/src/models/dbss/package.dart';
import 'package:business/src/models/dbss/product.dart';
import 'package:business/src/models/dbss/subscription_type.dart';
import 'package:business/src/models/enums/category.dart';
import 'package:business/src/models/il/Subscriber.dart';
import 'package:business/src/models/response/apim_response.dart';
import 'package:get/get.dart';
import '/src/services/api/api.dart';
import '/src/repositories/user_repository.dart';
import '/src/models/response/pair.dart';
import '/src/exceptions/bad_request_exception.dart';

enum AuthStatus {
  unverified,
  uninitialized,
  authenticated,
  unauthenticated,
  otpAccepted
}

class AuthController extends BaseController {
  bool _loader = false;
  AuthStatus _status = AuthStatus.uninitialized;

  AuthStatus get status => _status;
  late Subscriber subscriber;
  List<Package> connectedProducts = [];
  late SubscriptionType subscriptionType;
  List<Product> services = [];

  loadSubscriber() async {
    //Request to display message on SplashScreen
    updateStatus(Pair(Status.starting, Reason.idle));

    try {
      if (status == AuthStatus.uninitialized ||
          status == AuthStatus.otpAccepted) {
        //Retrieve and store user info on data_provider
        ApimResponse? response = await UserRepository.getInfo(
            null, [Api.connectedVal, Api.illegibilityVal]);
        subscriber = response!.subscriber!;
        if (response.includes!.isNotEmpty) {
          List<Package> packs = [];
          for (var include in response.includes!) {
            if (include.type == Api.connectedVal) {
              Product p = include as Product;
              packs.addAll(p.packs!);
            }
            if (include.type == Api.illegibilityVal) {
              Product p = include as Product;
              services.add(p);
            }
            if (include.type == Api.subsTypeVal) {
              subscriptionType = include as SubscriptionType;
            }
          }
          for (var pack in packs) {
            if (pack.balances!.isNotEmpty && pack.show!) {
              connectedProducts.add(pack);
            }
          }
        }
        update(['subscriber']);
        //Update service status
        setStatus(AuthStatus.authenticated);
      }
    } catch (ex) {
      if (ex is BadRequestException) {
        setStatus(AuthStatus.unauthenticated);
      } else {
        if (ex is SocketException) {
          //Request to display message on SplashScreen
          updateStatus(Pair(Status.error, Reason.network));
        } else {
          //Request to display message on SplashScreen
          updateStatus(Pair(Status.error, Reason.unknown));
        }
      }
    }
  }

  //#region Getters/Setters

  bool getLoader() {
    return _loader;
  }

  void setLoader(bool value) {
    _loader = value;
    update(["loader"]);
  }

  AuthStatus getStatus() {
    return _status;
  }

  void setStatus(AuthStatus value) {
    _status = value;
    update(['status']);
  }

  bool isFlexyIligible() {
    var result = services
        .firstWhereOrNull((service) => service.category == Category.flexy);
    return result == null ? false : true;
  }
}
