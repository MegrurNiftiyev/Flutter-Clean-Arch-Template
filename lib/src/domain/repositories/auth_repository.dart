import '../models/user_model.dart';

abstract class IAuthRepository {
  Future<UserModel> login({
    required String email,
    required String password,
  });

  Future<UserModel> register({
    required String email,
    required String password,
    String? name,
  });

  Future<void> forgotPassword({
    required String email,
  });
}
