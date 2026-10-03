import '../../repositories/settings_repository.dart';

class LogoutUseCase {
  final ISettingsRepository repository;

  LogoutUseCase({required this.repository});

  Future<void> call() async {
    await repository.logout();
  }
}
