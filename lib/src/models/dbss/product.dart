
import 'package:business/src/models/enums/category.dart';
import 'package:business/src/models/enums/payment_type.dart';

import 'package:business/src/models/il/name.dart';
import 'package:business/src/models/base_model.dart';
import 'package:business/src/models/dbss/package.dart';

class Product extends BaseModel  {

  final bool? show;
  final Name? name;
  final Category? category;
  final List<Package>? packs;

  const Product({
    super.id,
    super.type,
    this.show,
    this.name,
    this.packs,
    this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json, PaymentType? paymentType) {
    var baseModel = BaseModel.fromJson(json);
    return Product(
      id: baseModel.id,
      type: baseModel.type,
      show: json['attributes']['show'] as bool?,
      name: Name.fromJson(json['attributes']['name']),
      category: Category.get(json['attributes']['category']),
      packs: ((json['attributes']['products'] ?? []) as List)
          .map((item) => Package.fromJson(item, paymentType)).toList(),
    );
  }
}