
import 'package:business/src/models/enums/category.dart';
import 'package:business/src/models/il/name.dart';
import 'package:business/src/models/base_model.dart';
import 'package:business/src/helpers/text_helper.dart';

class Subscription extends BaseModel {

  final Name? name; //commercial-name
  final String? code;
  final dynamic date; //scheduled-at
  final double? price;
  final String? status;
  final bool? illegible; //is-eligible
  final Category? category;

  Subscription({
    required super.id,
    required super.type,
    this.name, //commercial-name
    this.code,
    this.date, //scheduled-at
    this.price,
    this.status,
    this.illegible, //is-eligible
    this.category,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) {
    var baseModel = BaseModel.fromJson(json);
    return Subscription(
      id: baseModel.id,
      type: baseModel.type,
      name: Name.fromJson(json['attributes']['commercial-name']),
      code: json['attributes']['code'],
      date: json['attributes']['scheduled-at'],
      price: TextHelper.getDouble(json['attributes']['price']),
      status: json['attributes']['status'],
      illegible: json['attributes']['is-eligible'],
      category: Category.get(json['attributes']['category']),
    );
  }
}