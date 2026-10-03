import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../enums/app_language.dart';
import '../enums/app_region.dart';

class LocalizationInterceptor extends Interceptor {
  final AppLanguage Function()? getCurrentLanguage;
  final AppRegion Function()? getCurrentRegion;

  LocalizationInterceptor({
    this.getCurrentLanguage,
    this.getCurrentRegion,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final language = getCurrentLanguage?.call() ?? AppLanguage.en;
    final region = getCurrentRegion?.call() ?? AppRegion.us;

    options.headers[ApiConstants.acceptLanguageHeader] = language.code;
    options.headers[ApiConstants.xRegionHeader] = region.code;

    super.onRequest(options, handler);
  }
}
