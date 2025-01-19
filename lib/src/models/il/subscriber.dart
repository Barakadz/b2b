
import 'package:business/src/models/base_model.dart';
import 'package:business/src/helpers/text_helper.dart';
import 'package:business/src/models/dbss/package.dart';
import 'package:business/src/models/enums/payment_type.dart';

class Subscriber extends BaseModel {

  final String? status;
  final String? msisdn;
  final double? balance;
  final String? language;
  final String? category;
  final String? subscriptionId;
  final PaymentType? paymentType;
  final bool? isCompany;
  final bool? isFleetManager;
  final String? customerId;
  final bool? isFlexyEligible;
  final String? connectionType;
  final String? activationTime;
  final String? segmentation;
  final double? creditLimit;

  final String? firstName;
  final String? lastName;

  List<Package>? packages;

  Subscriber({
    super.id,
    super.type,
    this.status,
    this.msisdn,
    this.balance,
    this.language,
    this.category,
    this.subscriptionId,
    this.paymentType,
    this.isCompany,
    this.isFleetManager,
    this.customerId,
    this.isFlexyEligible,
    this.connectionType,
    this.activationTime,
    this.segmentation,
    this.creditLimit,
    this.firstName,
    this.lastName,
    this.packages,
  });

  factory Subscriber.fromJson(Map<String, dynamic> json) {
    var baseModel = BaseModel.fromJson(json);
    if(json['attributes']==null){
      return Subscriber(
        id: baseModel.id,
        type: baseModel.type,
      );
    }
    var subscriber = Subscriber(
      id: baseModel.id,
      type: baseModel.type,
      status: json['attributes']['status'],
      msisdn: json['attributes']['msisdn'],
      balance: TextHelper.getDouble(json['attributes']['balance']),
      language: json['attributes']['language'],
      category: json['attributes']['category'],
      subscriptionId: json['attributes']['subscription-id'],
      paymentType: PaymentType.get(json['attributes']['payment-type']),
      isCompany: json['attributes']['is-company'],
      isFleetManager: json['attributes']['is-fleet-manager'],
      customerId: json['attributes']['customer-id'],
      isFlexyEligible: json['attributes']['is-flexy-eligible'],
      connectionType: json['attributes']['connection-type'],
      activationTime: json['attributes']['activation-time'],
      segmentation: json['attributes']['segmentation-category'],
      creditLimit: TextHelper.getDouble(json['attributes']['credit-limit']),
      firstName: json['attributes']['first-name'],
      lastName: json['attributes']['last-name'],
    );

    //Set packages
    subscriber.packages = ((json['packages'] ?? []) as List).map((jsonItem) {
      return Package.fromJson(jsonItem, subscriber.paymentType);
    }).toList();

    return subscriber;
  }
}
