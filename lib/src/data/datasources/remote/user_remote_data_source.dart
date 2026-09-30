import '../../models/request/user_update_request.dart';
import '../../models/response/user_response.dart';

class UserRemoteDataSource {
  Future<UserResponse> getUserProfile(String userId) async {
    throw UnimplementedError();
  }

  Future<UserResponse> updateUserProfile(UserUpdateRequest request) async {
    throw UnimplementedError();
  }
}
