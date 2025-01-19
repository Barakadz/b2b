import 'package:business/src/models/other/faq.dart';

class FaqListModel {
  String? id;
  String? type;
  String? message;
  int? code;
  String? category;
  List<FaqModel>? informations;

  FaqListModel(
      {this.id,
      this.type,
      this.message,
      this.code,
      this.category,
      this.informations});

  factory FaqListModel.fromJson(Map<String, dynamic> json) {
    return FaqListModel(
      id: json['faq'][0]['id'] ?? '',
      type: json['faq'][0]['type'] ?? '',
      message: json['message'],
      code: json['code'],
      category: json['faq'][0]['attributes']['category'] ?? '',
      informations: FaqModel.faqModelsList(List<Map<String, dynamic>>.from(
          json['faq'][0]['attributes']['informations'] ?? [])),
    );
  }
}
