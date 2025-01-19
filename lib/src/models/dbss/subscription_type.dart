
import 'package:business/src/models/il/name.dart';
import 'package:business/src/models/base_model.dart';

import 'package:business/src/helpers/text_helper.dart';

class SubscriptionType extends BaseModel  {

  final String? code;
  final Name? name;
  final String? brand;
  final double? changePrice;
  final double? creditLimit;
  final String? paymentType;
  final String? businessModel;


  const SubscriptionType({
    super.id,
    super.type,
    this.code,
    this.name,
    this.brand,
    this.paymentType,
    this.creditLimit,
    this.changePrice,
    this.businessModel,
  });

  factory SubscriptionType.fromJson(Map<String, dynamic> json) {
    var baseModel = BaseModel.fromJson(json);
    return SubscriptionType(
      id: baseModel.id,
      type: baseModel.type,
      code: json['attributes']['code'] as String?,
      name: Name.fromJson(json['attributes']['name']),
      brand: json['attributes']['brand'] as String?,
      paymentType: json['attributes']['payment-type'] as String?,
      creditLimit: TextHelper.getDouble(json['attributes']['credit-limit']),
      changePrice: TextHelper.getDouble(json['attributes']['change-price']),
      businessModel: json['attributes']['business-model-type'] as String?,
    );
  }
}