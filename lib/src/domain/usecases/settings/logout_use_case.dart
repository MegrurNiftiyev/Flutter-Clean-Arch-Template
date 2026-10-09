import '../../../core/helpers/result.dart';
import '../../../core/exceptions/settings_exception.dart';
import '../../repositories/settings_repository.dart';

class LogoutUseCase {
  final ISettingsRepository repository;

  LogoutUseCase( this.repository);

  Future<Result<void>> call() {
    return repository.logout();
  }
}
