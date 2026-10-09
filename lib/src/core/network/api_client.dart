import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../constants/durations.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/error_interceptor.dart';
import '../interceptors/localization_interceptor.dart';
import '../managers/env_manager.dart';

class ApiClient {
  late final Dio dio;
  late final Dio plainDio;

  ApiClient({
    String? baseUrl,
    AuthInterceptor? authInterceptor,
    LocalizationInterceptor? localizationInterceptor,
    ErrorInterceptor? errorInterceptor,
  }) {
    plainDio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? EnvManager.baseUrl,
        connectTimeout: AppDurations.s15,
        receiveTimeout: AppDurations.s15,
        headers: {
          ApiConstants.contentTypeHeader: ApiConstants.applicationJson,
          ApiConstants.acceptHeader: ApiConstants.applicationJson,
          ApiConstants.xPlatformHeader: ApiConstants.platformMobile,
        },
      ),
    );

    dio = Dio(plainDio.options.copyWith());

    if (authInterceptor != null) {
      dio.interceptors.add(authInterceptor);
    }
    if (localizationInterceptor != null) {
      dio.interceptors.add(localizationInterceptor);
      plainDio.interceptors.add(localizationInterceptor);
    } else {
      final loc = LocalizationInterceptor();
      dio.interceptors.add(loc);
      plainDio.interceptors.add(loc);
    }
    if (errorInterceptor != null) {
      dio.interceptors.add(errorInterceptor);
      plainDio.interceptors.add(errorInterceptor);
    } else {
      final err = ErrorInterceptor();
      dio.interceptors.add(err);
      plainDio.interceptors.add(err);
    }

    dio.interceptors.add(LogInterceptor(responseBody: true));
    plainDio.interceptors.add(LogInterceptor(responseBody: true));
  }
}
