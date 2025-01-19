
import 'package:flutter/material.dart';

import 'package:business/src/models/il/name.dart';
import 'package:business/src/models/enums/unit.dart';
import 'package:business/src/helpers/text_helper.dart';

import '../enums/bundle_type.dart';
import '../enums/traffic_type.dart';

class Balance {

  final String? id;
  final Name? name;
  final Unit? unit;
  final double? amount;
  final bool? unlimited;
  final int? order;
  final double? total;
  final BundleType? type;
  final double? remaining;
  final bool? isShareable;
  final Name? description;
  final TrafficType? trafficType;

  const Balance({
    this.id,
    this.name,
    this.unit,
    this.amount,
    this.unlimited,
    this.order,
    this.total,
    this.type,
    this.remaining,
    this.isShareable,
    this.description,
    this.trafficType,
  });

  factory Balance.fromJson(Map<String, dynamic> json) {
    return Balance(
      id: json['id'],
      name: Name.fromJson(json['name']),
      unit: Unit.get(json['unit']),
      amount: TextHelper.getDouble(json['remaining-amount']),
      unlimited: json['unlimited'],
      order: json['display-order'],
      total: TextHelper.getDouble(json['total-amount']),
      type: BundleType.get(json['bundle-type']),
      remaining: TextHelper.getDouble(json['amount']),
      isShareable: json['is-shareable'],
      description: Name.fromJson(json['short-description']),
      trafficType: TrafficType.get(json['traffic-type']),
    );
  }
}

extension BalanceEx on Balance {

  IconData getIcon() {
    switch (type) {
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

  String getQuota(){

    //Get unit
    int divider = 1;
    switch (unit){
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
    if(unlimited == true) {
      return "unlimit";
    } else {
      return "${(remaining==null ? 0:remaining!/divider).toStringAsFixed(0)} "
          "/"
          "${(total==null ? 0:total!/divider).toStringAsFixed(0)}"
          " ${unit?.format()}";
    }
  }

  double getRatio() {
    if(total==null || total! <= 0) {
      return 1;
    }
    return unlimited == true ? 1 : (remaining ?? 1) / (total ?? 1);
  }

  int compare(Balance other) {

    if(unlimited==true && other.unlimited==true) {
      if(type == BundleType.data) {
        return -1;
      }
      else if((type == BundleType.money || type == BundleType.credit) && other.type != BundleType.data) {
        return -1;
      }
      else if(type == BundleType.voice && other.type != BundleType.data && other.type != BundleType.money && other.type != BundleType.credit) {
        return -1;
      }
    }
    else if(unlimited == true) {
      return 1;
    }
    else if(other.unlimited == true) {
      return -1;
    }
    else if(type == other.type) {
      if(trafficType == TrafficType.national) {
        return -1;
      }
    }
    else if(type == BundleType.data){
      return -1;
    }
    else if((type == BundleType.money || type == BundleType.credit) && other.type != BundleType.data){
      return -1;
    }
    else if(type == BundleType.voice && other.type != BundleType.data && other.type != BundleType.money && other.type != BundleType.credit){
      return -1;
    }
    return 1;
  }
}