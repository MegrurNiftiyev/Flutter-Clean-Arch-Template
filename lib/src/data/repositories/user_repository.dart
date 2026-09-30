import '../datasources/remote/user_remote_data_source.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepository implements IUserRepository {
  UserRepository({
    required this.remoteDataSource,
  });

  final IUserRemoteDataSource remoteDataSource;

  @override
  Future<UserModel> getUserProfile({
    required String userId,
  }) async {
    return remoteDataSource.getUserProfile(userId: userId);
  }

  @override
  Future<UserModel> updateUserProfile({
    required String userId,
    String? name,
  }) async {
    return remoteDataSource.updateUserProfile(userId: userId, name: name);
  }
}
