import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

class GetUserProfileUseCase {
  GetUserProfileUseCase({
    required this.repository,
  });

  final IUserRepository repository;

  Future<UserModel> call({
    required String userId,
  }) {
    return repository.getUserProfile(
      userId: userId,
    );
  }
}
