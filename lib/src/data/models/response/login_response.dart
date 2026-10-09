import '../../../domain/models/auth_model.dart';
import '../dto/user_dto.dart';

class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final UserDto user;

  const LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    final tokens = json['tokens'] as Map<String, dynamic>? ?? {};
    return LoginResponse(
      accessToken: tokens['accessToken'] as String? ?? '',
      refreshToken: tokens['refreshToken'] as String? ?? '',
      user: UserDto.fromJson(json['user'] as Map<String, dynamic>? ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'accessToken': accessToken,
      'refreshToken': refreshToken,
      'user': user.toJson(),
    };
  }

  AuthModel toDomain() {
    final userDomain = user.toDomain();
    return AuthModel(
      id: userDomain.id,
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: userDomain,
    );
  }
}
