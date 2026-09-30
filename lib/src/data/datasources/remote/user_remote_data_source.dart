import '../../../domain/models/user_model.dart';

abstract class IUserRemoteDataSource {
  Future<UserModel> getUserProfile({
    required String userId,
  });

  Future<UserModel> updateUserProfile({
    required String userId,
    String? name,
  });
}

class UserRemoteDataSource implements IUserRemoteDataSource {
  @override
  Future<UserModel> getUserProfile({
    required String userId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<UserModel> updateUserProfile({
    required String userId,
    String? name,
  }) async {
    throw UnimplementedError();
  }
}
