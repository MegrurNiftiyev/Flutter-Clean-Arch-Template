import '../../../core/enums/api_endpoint.dart';
import '../../../core/helpers/execute_request.dart';
import '../../../core/exceptions/user_exception.dart';
import '../../../core/network/api_client.dart';
import '../../models/request/user_update_request.dart';
import '../../models/response/user_response.dart';

class UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSource(this.apiClient);

  Future<UserResponse> getUserProfile() {
    return executeRequest(
      expected: UserException.expected,
      () async {
        final res = await apiClient.dio.get(ApiEndpoint.userProfile.path);
        return UserResponse.fromJson(res.data);
      },
    );
  }

  Future<UserResponse> updateUserProfile(UserUpdateRequest request) {
    return executeRequest(
      expected: UserException.expected,
      () async {
        final res = await apiClient.dio.put(
          ApiEndpoint.userProfile.path,
          data: request.toJson(),
        );
        return UserResponse.fromJson(res.data);
      },
    );
  }
}
