class RefreshTokenResponse {
  final String accessToken;
  final String refreshToken;

  const RefreshTokenResponse({
    required this.accessToken,
    required this.refreshToken,
  });

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    final tokens = json['tokens'] as Map<String, dynamic>? ?? {};
    return RefreshTokenResponse(
      accessToken: tokens['accessToken'] as String? ?? '',
      refreshToken: tokens['refreshToken'] as String? ?? '',
    );
  }
}
