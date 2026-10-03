import '../../repositories/settings_repository.dart';

class GetThemeUseCase {
  final ISettingsRepository repository;

  GetThemeUseCase({required this.repository});

  Future<bool> call() async {
    return await repository.isDarkMode();
  }
}
