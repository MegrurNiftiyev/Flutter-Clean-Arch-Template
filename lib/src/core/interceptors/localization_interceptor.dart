import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../enums/language_code.dart';
import '../enums/app_region.dart';

class LocalizationInterceptor extends Interceptor {
  final LanguageCode Function()? getCurrentLanguage;
  final AppRegion Function()? getCurrentRegion;

  LocalizationInterceptor({
    this.getCurrentLanguage,
    this.getCurrentRegion,
  });

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final language = getCurrentLanguage?.call() ?? LanguageCode.en;
    final region = getCurrentRegion?.call() ?? AppRegion.us;

    options.headers[ApiConstants.xLanguageHeader] = language.code;
    options.headers[ApiConstants.xRegionHeader] = region.code;

    super.onRequest(options, handler);
  }
}
