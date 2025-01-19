
class TokenResponse  {

  final String tokenType;
  final String accessToken;
  final String refreshToken;

  const TokenResponse({
    required this.tokenType,
    required this.accessToken,
    required this.refreshToken,
  });

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      tokenType: json['token_type'] as String,
      accessToken: json['access_token'] as String,
      refreshToken: json['refresh_token'] as String,
    );
  }
}