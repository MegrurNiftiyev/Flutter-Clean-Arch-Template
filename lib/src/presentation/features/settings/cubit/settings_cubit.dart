import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/enums/status.dart';
import '../../../../domain/usecases/settings/get_language_use_case.dart';
import '../../../../domain/usecases/settings/get_theme_use_case.dart';
import '../../../../domain/usecases/settings/logout_use_case.dart';
import '../../../../domain/usecases/settings/update_language_use_case.dart';
import '../../../../domain/usecases/settings/update_theme_use_case.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final GetThemeUseCase _getThemeUseCase;
  final UpdateThemeUseCase _updateThemeUseCase;
  final GetLanguageUseCase _getLanguageUseCase;
  final UpdateLanguageUseCase _updateLanguageUseCase;
  final LogoutUseCase _logoutUseCase;

  SettingsCubit({
    required GetThemeUseCase getThemeUseCase,
    required UpdateThemeUseCase updateThemeUseCase,
    required GetLanguageUseCase getLanguageUseCase,
    required UpdateLanguageUseCase updateLanguageUseCase,
    required LogoutUseCase logoutUseCase,
  })  : _getThemeUseCase = getThemeUseCase,
        _updateThemeUseCase = updateThemeUseCase,
        _getLanguageUseCase = getLanguageUseCase,
        _updateLanguageUseCase = updateLanguageUseCase,
        _logoutUseCase = logoutUseCase,
        super(const SettingsState());

  Future<void> loadSettings() async {
    final isDark = await _getThemeUseCase();
    final lang = await _getLanguageUseCase();
    emit(state.copyWith(
      status: Status.Success,
      isDarkMode: isDark,
      languageCode: lang,
    ));
  }

  Future<void> toggleTheme(bool isDark) async {
    emit(state.copyWith(status: Status.Loading));
    try {
      await _updateThemeUseCase(isDark);
      emit(state.copyWith(
        status: Status.Success,
        isDarkMode: isDark,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.Failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    emit(state.copyWith(status: Status.Loading));
    try {
      await _updateLanguageUseCase(languageCode);
      emit(state.copyWith(
        status: Status.Success,
        languageCode: languageCode,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.Failure,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> logout() async {
    emit(state.copyWith(status: Status.Loading));
    try {
      await _logoutUseCase();
      emit(state.copyWith(
        status: Status.Success,
        isLoggedOut: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: Status.Failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
