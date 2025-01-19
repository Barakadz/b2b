import 'package:business/src/models/il/name.dart';

class FaqModel {
  Name? question;
  Name? answer;

  FaqModel({this.question, this.answer});

  factory FaqModel.fromJson(Map<String, dynamic> json) {
    return FaqModel(
        question: Name.fromJson(json['name']),
        answer: Name.fromJson(json['description']));
  }

  static List<FaqModel> faqModelsList(List<Map<String, dynamic>> json) {
    return json.map((e) => FaqModel.fromJson(e)).toList();
  }
}
