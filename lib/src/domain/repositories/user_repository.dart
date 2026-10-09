import '../../core/helpers/result.dart';
import '../../core/exceptions/user_exception.dart';
import '../models/user_model.dart';

abstract class IUserRepository {
  Future<Result<UserModel>> getUserProfile();

  Future<Result<UserModel>> updateUserProfile({
    required String userId,
    String? name,
  });
}
