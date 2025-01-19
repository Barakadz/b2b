import 'package:business/src/models/base_model.dart';

class FaqCategoryModel extends BaseModel {
  final String? item;
  final String? title;
  final int? order;
  const FaqCategoryModel(
      {required super.id,
      required super.type,
      this.item,
      this.title,
      this.order});

  factory FaqCategoryModel.fromJson(Map<String, dynamic> json) {
    var baseModel = BaseModel.fromJson(json);
    return FaqCategoryModel(
      id: baseModel.id,
      type: baseModel.type,
      item: json['attributes']['item'],
      title: json['attributes']['title'],
      order: json['attributes']['order'],
    );
  }
}
