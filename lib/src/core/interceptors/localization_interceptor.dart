import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../enums/app_region.dart';
import '../enums/language_code.dart';
import '../managers/localization_manager.dart';

class LocalizationInterceptor extends Interceptor {
  final LanguageCode Function()? getCurrentLanguage;
  final AppRegion Function()? getCurrentRegion;
  final LocalizationManager localizationManager;

  LocalizationInterceptor({
    this.getCurrentLanguage,
    this.getCurrentRegion,
    LocalizationManager? localizationManager,
  }) : localizationManager = localizationManager ?? const LocalizationManager();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final language =
        getCurrentLanguage?.call() ?? localizationManager.getSystemLanguage();
    final region = getCurrentRegion?.call() ??
        localizationManager.getSystemRegion(language);

    options.headers[ApiConstants.xLanguageHeader] = language.code;
    options.headers[ApiConstants.xRegionHeader] = region.code;

    super.onRequest(options, handler);
  }
}
