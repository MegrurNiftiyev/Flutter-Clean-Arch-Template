import '../../presentation/global_cubits/settings/settings_cubit.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/error_interceptor.dart';
import '../interceptors/localization_interceptor.dart';
import '../managers/encrypted_cache_manager.dart';
import '../network/api_client.dart';
import 'dependency_injection.dart';

void initializeNetwork() {
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      authInterceptor: sl<AuthInterceptor>(),
      localizationInterceptor: sl<LocalizationInterceptor>(),
      errorInterceptor: sl<ErrorInterceptor>(),
    ),
  );

  sl.registerLazySingleton<AuthInterceptor>(
    () => AuthInterceptor(
      sl<EncryptedCacheManager>(),
      retryDio: () => sl<ApiClient>().plainDio,
      onSessionExpired: () {
        if (sl.isRegistered<SettingsCubit>()) {
          sl<SettingsCubit>().logout();
        }
      },
    ),
  );
  sl.registerLazySingleton<LocalizationInterceptor>(
    () => LocalizationInterceptor(
      getCurrentLanguage: () {
        if (sl.isRegistered<SettingsCubit>()) {
          return sl<SettingsCubit>().state.language;
        }
        return LocalizationInterceptor.getSystemLanguage();
      },
      getCurrentRegion: () {
        final currentLang = sl.isRegistered<SettingsCubit>()
            ? sl<SettingsCubit>().state.language
            : LocalizationInterceptor.getSystemLanguage();
        return LocalizationInterceptor.getSystemRegion(currentLang);
      },
    ),
  );
  sl.registerLazySingleton<ErrorInterceptor>(() => ErrorInterceptor());
}
