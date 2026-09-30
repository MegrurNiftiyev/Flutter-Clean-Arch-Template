import '../../../domain/models/user_model.dart';

abstract class IAuthRemoteDataSource {
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

class AuthRemoteDataSource implements IAuthRemoteDataSource {
  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    String? name,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    throw UnimplementedError();
  }
}
