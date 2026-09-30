import '../models/user_model.dart';

abstract class IUserRepository {
  Future<UserModel> getUserProfile({
    required String userId,
  });

  Future<UserModel> updateUserProfile({
    required String userId,
    String? name,
  });
}
