import 'package:business/src/models/other/wilaya.dart';

class Wilayas {
  List<Wilaya>? data;
  Wilayas({this.data});

  factory Wilayas.fromJson(Map<String, dynamic> json) {
    return Wilayas(
        data: ((json['data'] ?? []) as List)
            .map((e) => Wilaya.fromJson(e))
            .toList());
  }
}
