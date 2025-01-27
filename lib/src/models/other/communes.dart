import 'package:business/src/models/other/commune.dart';

class Communes {
  List<Commune>? data;
  Communes({this.data});

  factory Communes.fromJson(Map<String, dynamic> json) {
    return Communes(
        data: ((json['result'] ?? []) as List)
            .map((e) => Commune.fromJson(e))
            .toList());
  }
}
