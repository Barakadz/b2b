import 'package:business/src/models/il/Transaction.dart';
import 'package:business/src/services/api/api.dart';
import 'package:business/src/models/dbss/Invoice.dart';

import 'package:business/src/models/base_model.dart';
import 'package:business/src/models/dbss/product.dart';
import 'package:business/src/models/il/Subscriber.dart';
import 'package:business/src/models/dbss/subscription.dart';
import 'package:business/src/models/dbss/subscription_type.dart';

class ApimResponse {
  final int? status;
  final String? message;

  final String? tokenType;
  final String? accessToken;
  final String? refreshToken;

  final Subscriber? subscriber;
  final List<Subscriber>? subscribers;

  List<BaseModel>? includes;

  ApimResponse(
      {this.status,
      this.message,
      this.tokenType,
      this.accessToken,
      this.refreshToken,
      this.subscriber,
      this.subscribers,
      this.includes});

  factory ApimResponse.fromJson(Map<String, dynamic> json) {
    // Init response
    var response = ApimResponse(
      status: json['status'] as int?,
      message: json['message'] as String?,
      tokenType: json['token_type'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      subscriber: Subscriber.fromJson(json['data'] ?? <String, dynamic>{}),
    );

    // Add includes
    response.includes = ((json['included'] ?? []) as List).map(
      (jsonItem) {
        var item = BaseModel.fromJson(jsonItem);
        if (item.type?.contains(Api.subsTypeVal) == true) {
          item = SubscriptionType.fromJson(jsonItem);
        } else if (item.type?.contains(Api.illegibilityVal) == true) {
          item = Product.fromJson(jsonItem, response.subscriber?.paymentType);
        } else if (item.type?.contains(Api.connectedVal) == true) {
          item = Product.fromJson(jsonItem, response.subscriber?.paymentType);
        } else if (item.type?.contains(Api.flashProductsVal) == true) {
          item = Product.fromJson(jsonItem, response.subscriber?.paymentType);
        } else if (item.type?.contains(Api.subscriptionsVal) == true) {
          item = Subscription.fromJson(jsonItem);
        } else if (item.type?.contains(Api.surpriseVal) == true) {
          item = Product.fromJson(jsonItem, response.subscriber?.paymentType);
        } else if (item.type?.contains(Api.billInfoVal) == true) {
          item = Invoice.fromJson(jsonItem);
        } else if (item.type?.contains(Api.flexyHistoryVaL2) == true) {
          item = Transaction.fromJson(jsonItem);
        }
        return item;
      },
    ).toList();

    return response;
  }
}
