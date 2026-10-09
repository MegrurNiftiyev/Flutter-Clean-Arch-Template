import '../../../core/helpers/result.dart';
import '../../../core/exceptions/user_exception.dart';
import '../../models/user_model.dart';
import '../../repositories/user_repository.dart';

class GetUserProfileUseCase {
  final IUserRepository repository;

  const GetUserProfileUseCase(this.repository);

  Future<Result<UserModel>> call() {
    return repository.getUserProfile();
  }
}
