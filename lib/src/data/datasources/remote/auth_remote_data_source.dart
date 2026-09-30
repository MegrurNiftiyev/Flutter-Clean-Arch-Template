import '../../models/request/login_request.dart';
import '../../models/request/register_request.dart';
import '../../models/response/user_response.dart';

abstract class AuthRemoteDataSource {
  Future<UserResponse> login(LoginRequest request);
  Future<UserResponse> register(RegisterRequest request);
  Future<void> forgotPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserResponse> login(LoginRequest request) async {
    throw UnimplementedError();
  }

  @override
  Future<UserResponse> register(RegisterRequest request) async {
    throw UnimplementedError();
  }

  @override
  Future<void> forgotPassword(String email) async {
    throw UnimplementedError();
  }
}
