import 'dart:ui';
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
    final language = getCurrentLanguage?.call() ?? getSystemLanguage();
    final region = getCurrentRegion?.call() ?? getSystemRegion(language);

    options.headers[ApiConstants.xLanguageHeader] = language.code;
    options.headers[ApiConstants.xRegionHeader] = region.code;

    super.onRequest(options, handler);
  }

  static LanguageCode getSystemLanguage() {
    final systemLang = PlatformDispatcher.instance.locale.languageCode;
    return LanguageCode.fromCode(systemLang);
  }

  static AppRegion getSystemRegion([LanguageCode? language]) {
    final systemCountry = PlatformDispatcher.instance.locale.countryCode;
    if (systemCountry != null && systemCountry.isNotEmpty) {
      final matched = AppRegion.values.where(
        (r) => r.code.toUpperCase() == systemCountry.toUpperCase(),
      );
      if (matched.isNotEmpty) {
        return matched.first;
      }
    }

    final targetLang = language ?? getSystemLanguage();
    return getRegionForLanguage(targetLang);
  }

  static AppRegion getRegionForLanguage(LanguageCode language) {
    switch (language) {
      case LanguageCode.tr:
        return AppRegion.tr;
      case LanguageCode.az:
        return AppRegion.az;
      case LanguageCode.ru:
        return AppRegion.ru;
      case LanguageCode.es:
        return AppRegion.es;
      case LanguageCode.de:
        return AppRegion.de;
      case LanguageCode.fr:
        return AppRegion.fr;
      case LanguageCode.ar:
        return AppRegion.sa;
      case LanguageCode.en:
        return AppRegion.us;
    }
  }
}
