import 'base/base_model.dart';
import 'user_model.dart';

class AuthModel extends BaseModel {
  final String accessToken;
  final String refreshToken;
  final UserModel user;

  const AuthModel({
    required super.id,
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });
}
