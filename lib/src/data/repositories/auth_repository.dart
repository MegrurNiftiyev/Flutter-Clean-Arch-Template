import '../datasources/remote/auth_remote_data_source.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/i_auth_repository.dart';

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required this.remoteDataSource,
  });

  final IAuthRemoteDataSource remoteDataSource;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    return remoteDataSource.login(email: email, password: password);
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    String? name,
  }) async {
    return remoteDataSource.register(email: email, password: password, name: name);
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    return remoteDataSource.forgotPassword(email: email);
  }
}
