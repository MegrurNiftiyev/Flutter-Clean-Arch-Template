import '../../models/request/login_request.dart';
import '../../models/request/register_request.dart';
import '../../models/response/user_response.dart';

class AuthRemoteDataSource {
  Future<UserResponse> login(LoginRequest request) async {
    throw UnimplementedError();
  }

  Future<UserResponse> register(RegisterRequest request) async {
    throw UnimplementedError();
  }

  Future<void> forgotPassword(String email) async {
    throw UnimplementedError();
  }
}
