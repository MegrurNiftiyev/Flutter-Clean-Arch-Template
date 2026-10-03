import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../constants/durations.dart';
import '../interceptors/auth_interceptor.dart';
import '../interceptors/error_interceptor.dart';
import '../interceptors/localization_interceptor.dart';
import '../managers/env_manager.dart';

class ApiClient {
  late final Dio dio;

  ApiClient({
    String? baseUrl,
    AuthInterceptor? authInterceptor,
    LocalizationInterceptor? localizationInterceptor,
    ErrorInterceptor? errorInterceptor,
  }) {
    dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? EnvManager.baseUrl,
        connectTimeout: AppDurations.apiTimeout,
        receiveTimeout: AppDurations.apiTimeout,
        headers: {
          ApiConstants.contentTypeHeader: ApiConstants.applicationJson,
          ApiConstants.acceptHeader: ApiConstants.applicationJson,
        },
      ),
    );

    if (authInterceptor != null) {
      dio.interceptors.add(authInterceptor);
    }
    if (localizationInterceptor != null) {
      dio.interceptors.add(localizationInterceptor);
    } else {
      dio.interceptors.add(LocalizationInterceptor());
    }
    if (errorInterceptor != null) {
      dio.interceptors.add(errorInterceptor);
    } else {
      dio.interceptors.add(ErrorInterceptor());
    }

    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
}
