
class RegistrationResponse  {

  final int status;
  final String message;

  const RegistrationResponse({
    required this.status,
    required this.message,
  });

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      status: json['status'] as int,
      message: json['message'] as String,
    );
  }
}