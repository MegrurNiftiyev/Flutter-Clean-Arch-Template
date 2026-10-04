import '../../../core/helpers/result.dart';
import '../../repositories/auth_repository.dart';

class RefreshTokenUseCase {
  final IAuthRepository repository;

  const RefreshTokenUseCase(this.repository);

  Future<Result<void>> call() {
    return repository.refreshToken();
  }
}
