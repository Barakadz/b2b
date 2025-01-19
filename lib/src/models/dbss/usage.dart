import 'package:business/src/helpers/text_helper.dart';

import 'package:business/src/models/il/name.dart';
import 'package:business/src/models/dbss/balance.dart';

import 'package:business/src/models/enums/unit.dart';
import 'package:business/src/models/enums/bundle_type.dart';
import 'package:business/src/models/enums/traffic_type.dart';

class Usage extends Balance {
  const Usage({
    super.id,
    super.name,
    super.unit,
    super.total,
    super.unlimited,
    super.amount,
    super.order,
    super.type,
    super.remaining,
    super.isShareable,
    super.description,
    super.trafficType,
  });

  factory Usage.fromJson(Map<String, dynamic> json) {
    return Usage(
        id: json['id'],
        name: Name.fromJson(json['name']),
        unit: Unit.get(json['unit']),
        total: TextHelper.getDouble(json['total']),
        unlimited: json['unlimited-usage'],
        amount: TextHelper.getDouble(json['used']),
        order: json['display-order'],
        type: BundleType.get(json['type']),
        remaining: TextHelper.getDouble(json['left']),
        isShareable: json['is-shareable'],
        description: Name.fromJson(json['short-description']),
        trafficType: TrafficType.get(json['category']));
  }
}
