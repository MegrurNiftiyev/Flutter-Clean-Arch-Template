import '../../../core/helpers/result.dart';
import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

class GetUserProfileUseCase {
  final IUserRepository repository;

  const GetUserProfileUseCase({required this.repository});

  Future<Result<UserModel>> call() {
    return repository.getUserProfile();
  }
}
