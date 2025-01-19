import 'package:flutter/material.dart';

import 'package:business/src/models/il/name.dart';
import 'package:business/src/models/enums/unit.dart';
import 'package:business/src/models/enums/bundle_type.dart';

import 'package:business/src/helpers/text_helper.dart';

class Bundle {
  final String? id;
  final bool? unlimited;
  final int? order;
  final double? amount;
  final Name? description;
  final Unit? usageUnit;
  final BundleType? usageType;
  final String? trafficType;

  const Bundle({
    this.id,
    this.unlimited,
    this.order,
    this.amount,
    this.description,
    this.usageUnit,
    this.usageType,
    this.trafficType,
  });

  factory Bundle.fromJson(Map<String, dynamic> json) {
    return Bundle(
      id: json['id'] as String?,
      unlimited: json['unlimited'] as bool?,
      order: json['display-order'] as int?,
      amount: TextHelper.getDouble(json['free-usage-amount']),
      description: Name.fromJson(json['commercial-name']),
      usageUnit: Unit.get(json['usage-unit'] ?? ""),
      usageType: BundleType.get(json['usage-type'] ?? ""),
      trafficType: json['Traffic-type'] as String?,
    );
  }

  String getQuota() {
    //Get unit
    int divider = 1;
    switch (usageUnit) {
      case Unit.tb:
        divider = 1048576;
        break;
      case Unit.gb:
        divider = 1024;
        break;
      default:
        divider = 1;
        break;
    }
    if (unlimited == true) {
      return "unlimit";
    } else {
      return "${TextHelper.doubleToCeil(amount == null ? 0 : amount! / divider)} ${usageUnit?.format()}";
    }
  }

  IconData getIcon() {
    switch (usageType) {
      case BundleType.data:
        return Icons.language;
      case BundleType.voice:
        return Icons.phone;
      case BundleType.money:
      case BundleType.credit:
        return Icons.money;
      case BundleType.sms:
        return Icons.sms;
      default:
        return Icons.no_accounts;
    }
  }
}
