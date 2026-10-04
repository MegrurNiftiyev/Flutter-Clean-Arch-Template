import '../../core/helpers/result.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote/user_remote_data_source.dart';
import '../models/request/user_update_request.dart';

class UserRepository implements IUserRepository {
  UserRepository({
    required this.remoteDataSource,
  });

  final UserRemoteDataSource remoteDataSource;

  @override
  Future<Result<UserModel>> getUserProfile() async {
    return safeCall(() async {
      final response = await remoteDataSource.getUserProfile();
      return response.toDomain();
    });
  }

  @override
  Future<Result<UserModel>> updateUserProfile({
    required String userId,
    String? name,
  }) async {
    return safeCall(() async {
      final request = UserUpdateRequest(userId: userId, name: name);
      final response = await remoteDataSource.updateUserProfile(request);
      return response.toDomain();
    });
  }
}
