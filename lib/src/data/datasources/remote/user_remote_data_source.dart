import '../../models/request/user_update_request.dart';
import '../../models/response/user_response.dart';

abstract class IUserRemoteDataSource {
  Future<UserResponse> getUserProfile(String userId);
  Future<UserResponse> updateUserProfile(UserUpdateRequest request);
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  @override
  Future<UserResponse> getUserProfile(String userId) async {
    throw UnimplementedError();
  }

  @override
  Future<UserResponse> updateUserProfile(UserUpdateRequest request) async {
    throw UnimplementedError();
  }
}
