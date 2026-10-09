import '../../../core/helpers/result.dart';
import '../../../core/exceptions/user_exception.dart';
import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

class UpdateUserProfileUseCase {
  final IUserRepository repository;

  UpdateUserProfileUseCase(this.repository);

  Future<Result<UserModel>> call({
    required String userId,
    String? name,
  }) {
    return repository.updateUserProfile(userId: userId, name: name);
  }
}
