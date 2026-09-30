import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

class UpdateUserProfileUseCase {
  UpdateUserProfileUseCase({
    required this.repository,
  });

  final IUserRepository repository;

  Future<UserModel> call({
    required String userId,
    String? name,
  }) {
    return repository.updateUserProfile(
      userId: userId,
      name: name,
    );
  }
}
