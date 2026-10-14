import '../../../core/helpers/result.dart';
import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

class UpdateUserProfileUseCase {
  final IUserRepository repository;

  const UpdateUserProfileUseCase({required this.repository});

  Future<Result<UserModel>> call({
    String? name,
  }) {
    return repository.updateUserProfile(name: name);
  }
}
