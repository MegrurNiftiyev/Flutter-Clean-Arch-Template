import '../datasources/remote/user_remote_data_source.dart';
import '../models/request/user_update_request.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepository implements IUserRepository {
  UserRepository({
    required this.remoteDataSource,
  });

  final UserRemoteDataSource remoteDataSource;

  @override
  Future<UserModel> getUserProfile({
    required String userId,
  }) async {
    final response = await remoteDataSource.getUserProfile(userId);
    return response.toDomain();
  }

  @override
  Future<UserModel> updateUserProfile({
    required String userId,
    String? name,
  }) async {
    final request = UserUpdateRequest(userId: userId, name: name);
    final response = await remoteDataSource.updateUserProfile(request);
    return response.toDomain();
  }
}
