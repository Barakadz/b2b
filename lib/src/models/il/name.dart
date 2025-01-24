
import 'package:get/get.dart';
 
class Name {

  final Map<String, dynamic>? text;

  const Name({
    this.text
  });

  String getValue(){
    //language of phone
    return text?[Get.locale?.languageCode] ?? "fr";
  }

  factory Name.fromJson(Map<String, dynamic>? json) {
    return Name(text: ((json ?? {})['text'] ?? <String, dynamic>{}) as Map<String, dynamic>);
  }
}