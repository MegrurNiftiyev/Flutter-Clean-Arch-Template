import '../../../core/helpers/result.dart';
import '../../repositories/settings_repository.dart';

class LogoutUseCase {
  final ISettingsRepository repository;

  const LogoutUseCase({required this.repository});

  Future<Result<void>> call() {
    return repository.logout();
  }
}
