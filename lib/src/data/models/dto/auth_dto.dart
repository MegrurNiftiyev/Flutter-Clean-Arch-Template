class AuthDto {
  final String accessToken;
  final String refreshToken;

  const AuthDto({
    required this.accessToken,
    required this.refreshToken,
  });

  factory AuthDto.fromJson(Map<String, dynamic> json) {
    return AuthDto(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
    };
  }
}
