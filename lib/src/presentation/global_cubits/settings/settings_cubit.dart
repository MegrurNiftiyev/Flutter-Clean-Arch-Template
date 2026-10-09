import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/enums/language_code.dart';

import '../../../core/constants/cache_keys.dart';
import '../../../core/enums/status.dart';
import '../../../core/helpers/result.dart';
import '../../../core/managers/cache_manager.dart';
import '../../../domain/usecases/settings/logout_use_case.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final LogoutUseCase logoutUseCase;
  final CacheManager cacheManager;

  SettingsCubit(this.logoutUseCase, this.cacheManager)
      : super(const SettingsState());

  Future<void> load() async {
    final isDark =
        await cacheManager.get<bool>(CacheKeys.boxName, CacheKeys.themeKey) ??
            false;
    final lang = await cacheManager.get<String>(
            CacheKeys.boxName, CacheKeys.languageKey) ??
        'en';
    emit(state.copyWith(isDarkMode: isDark, language: LanguageCode.fromCode(lang)));
  }

  Future<void> toggleTheme(bool isDark) async {
    await cacheManager.put(CacheKeys.boxName, CacheKeys.themeKey, isDark);
    emit(state.copyWith(isDarkMode: isDark));
  }

  Future<void> changeLanguage(String languageCode) async {
    await cacheManager.put(
        CacheKeys.boxName, CacheKeys.languageKey, languageCode);
    emit(state.copyWith(language: LanguageCode.fromCode(languageCode)));
  }

  Future<void> logout() async {
    emit(state.copyWith(status: Status.loading));
    final result = await logoutUseCase();
    result
        .onSuccess((_) => emit(state.copyWith(status: Status.success)))
        .onError((e) => emit(state.copyWith(status: Status.failure)));
  }
}
