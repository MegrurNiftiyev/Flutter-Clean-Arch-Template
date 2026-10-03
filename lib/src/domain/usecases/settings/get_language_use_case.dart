import '../../repositories/settings_repository.dart';

class GetLanguageUseCase {
  final ISettingsRepository repository;

  GetLanguageUseCase({required this.repository});

  Future<String> call() async {
    return await repository.getLanguage();
  }
}
