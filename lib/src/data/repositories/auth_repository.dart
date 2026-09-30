import '../datasources/remote/auth_remote_data_source.dart';
import '../models/request/login_request.dart';
import '../models/request/register_request.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/auth_repository.dart';

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
    final request = LoginRequest(email: email, password: password);
    final response = await remoteDataSource.login(request);
    return response.toDomain();
  }

  @override
  Future<UserModel> register({
    required String email,
    required String password,
    String? name,
  }) async {
    final request = RegisterRequest(email: email, password: password, name: name);
    final response = await remoteDataSource.register(request);
    return response.toDomain();
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    return remoteDataSource.forgotPassword(email);
  }
}
