import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/cache_keys.dart';
import '../../../core/enums/app_region.dart';
import '../../../core/enums/language_code.dart';
import '../../../core/enums/status.dart';
import '../../../core/helpers/result.dart';
import '../../../core/managers/cache_manager.dart';
import '../../../core/managers/localization_manager.dart';
import '../../../domain/usecases/settings/logout_use_case.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  final LogoutUseCase logoutUseCase;
  final CacheManager cacheManager;
  final LocalizationManager localizationManager;

  SettingsCubit({
    required this.logoutUseCase,
    required this.cacheManager,
    LocalizationManager? localizationManager,
  })  : localizationManager =
            localizationManager ?? const LocalizationManager(),
        super(
          SettingsState(
            language: (localizationManager ?? const LocalizationManager())
                .getSystemLanguage(),
            region: (localizationManager ?? const LocalizationManager())
                .getSystemRegion(),
          ),
        );

  Future<void> load() async {
    final isDark =
        await cacheManager.get<bool>(CacheKeys.boxName, CacheKeys.themeKey) ??
            false;
    final cachedLang = await cacheManager.get<String>(
      CacheKeys.boxName,
      CacheKeys.languageKey,
    );
    final cachedRegion = await cacheManager.get<String>(
      CacheKeys.boxName,
      CacheKeys.regionKey,
    );

    final language = (cachedLang != null && cachedLang.isNotEmpty)
        ? LanguageCode.fromCode(cachedLang)
        : localizationManager.getSystemLanguage();

    final region = (cachedRegion != null && cachedRegion.isNotEmpty)
        ? AppRegion.fromCode(cachedRegion)
        : localizationManager.getSystemRegion();

    emit(state.copyWith(
      isDarkMode: isDark,
      language: language,
      region: region,
    ));
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

  Future<void> changeRegion(String regionCode) async {
    await cacheManager.put(CacheKeys.boxName, CacheKeys.regionKey, regionCode);
    emit(state.copyWith(region: AppRegion.fromCode(regionCode)));
  }

  Future<void> logout() async {
    emit(state.copyWith(status: Status.loading));
    final result = await logoutUseCase();
    result
        .onSuccess((_) => emit(state.copyWith(status: Status.success)))
        .onError((e) => emit(state.copyWith(status: Status.failure)));
  }
}
