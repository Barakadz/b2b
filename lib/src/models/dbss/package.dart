import 'package:business/src/models/dbss/usage.dart';

import 'bundle.dart';
import 'balance.dart';

import '../il/name.dart';
import '../base_model.dart';

import '../enums/unit.dart';
import '../enums/category.dart';
import '../enums/bundle_type.dart';
import '../enums/payment_type.dart';

import 'package:business/src/helpers/text_helper.dart';

class Package extends BaseModel {
  final Name? name;
  final String? code;
  final double? price;
  final double? initialPrice;
  final bool? show;
  final Category? category;
  final bool? illegible;
  final Name? shortDescription;
  final Name? mediumDescription;
  final Name? longDescription;
  final int? validity;
  final Unit? validityUnit;
  final int? order;
  final dynamic expiryDate;
  final dynamic validityEndDate;
  final bool? isPromo;
  final bool? isCug;
  final bool? isChild;
  final bool? isFamilyShare;
  final List<Bundle>? bundles;
  final List<Balance>? balances;

  const Package({
    super.id,
    super.type,
    this.name,
    this.code,
    this.price,
    this.initialPrice,
    this.show,
    this.category,
    this.illegible,
    this.shortDescription,
    this.mediumDescription,
    this.longDescription,
    this.validity,
    this.validityUnit,
    this.order,
    this.expiryDate,
    this.validityEndDate,
    this.isPromo,
    this.isCug,
    this.isChild,
    this.isFamilyShare,
    this.bundles,
    this.balances,
  });

  factory Package.fromJson(
      Map<String, dynamic> json, PaymentType? paymentType) {
    var baseModel = BaseModel.fromJson(json);
    return Package(
      id: baseModel.id,
      type: baseModel.type,
      name: Name.fromJson(json['name']),
      code: json['code'],
      price: TextHelper.getDouble(json['price']),
      initialPrice: TextHelper.getDouble(json['discount-price']),
      show: json['show'],
      category: Category.get(json['category']),
      illegible: json['illegible'],
      shortDescription: Name.fromJson(json['short-description']),
      mediumDescription: Name.fromJson(json['medium-description']),
      longDescription: Name.fromJson(json['long-info-text']),
      validity: json['periodic-amount'],
      validityUnit: Unit.get(json['periodic-unit']),
      order: json['display-order'],
      expiryDate: json['expiry-at'],
      validityEndDate: json['valid-to'],
      isPromo: json['is-promo'],
      isCug: json['is-cug-product'],
      isChild: json['is-child'],
      isFamilyShare: json['is-family-product'],
      bundles: getBundles((json['bundles'] ?? [])),
      balances: paymentType == PaymentType.postpaid
          ? getUsage(json['usages'] ?? [])
          : getBalances(json['balances'] ?? []),
    );
  }

  String formatPrice() {
    return "${TextHelper.doubleToCeil(price!)} DA";
  }

  String formatValidity() {
    return "$validity ${validityUnit?.format()}";
  }

  static List<Bundle> getBundles(List list) {
    var bundles = list.map((item) => Bundle.fromJson(item)).toList();
    bundles.sort((a, b) => a.order?.compareTo(b.order ?? 999) ?? -1);
    return bundles;
  }

  static List<Balance> getBalances(List list) {
    var balances = list.map((item) => Balance.fromJson(item)).toList();
    balances.sort((a, b) => a.compare(b));
    return balances;
  }

  static List<Balance> getUsage(List list) {
    var balances = list.map((item) => Usage.fromJson(item)).toList();
    balances.sort((a, b) => a.compare(b));
    return balances;
  }

  static Bundle? getBundle(BundleType type, List<Bundle>? bundles) {
    int count = bundles != null ? bundles.length : 0;
    for (int i = 0; i < count; i++) {
      if (bundles!.elementAt(i).usageType == type) return bundles.elementAt(i);
    }
    return null;
  }
}
