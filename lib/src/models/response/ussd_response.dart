
import 'package:business/src/models/il/Subscriber.dart';

class UssdResponse {

  final int? code;
  final String? message;
  final List<Subscriber>? subscribers;

  const UssdResponse({
    this.code,
    this.message,
    this.subscribers
  });

  factory UssdResponse.fromJson(Map<String, dynamic> json) {
    return UssdResponse(
      code: json['code'] as int?,
      message: json['message'] as String?,
      subscribers: ((json['subscribers'] ?? []) as List).map((jsonItem) {
        return Subscriber.fromJson(jsonItem);
      }).toList(),
    );
  }
}