import 'dart:ui';

import '../enums/app_region.dart';
import '../enums/language_code.dart';

class LocalizationManager {
  const LocalizationManager();

  LanguageCode getSystemLanguage() {
    final systemLang = PlatformDispatcher.instance.locale.languageCode;
    return LanguageCode.fromCode(systemLang);
  }

  AppRegion getSystemRegion() {
    final systemCountry = PlatformDispatcher.instance.locale.countryCode;
    if (systemCountry != null && systemCountry.isNotEmpty) {
      return AppRegion.fromCode(systemCountry);
    }
    return AppRegion.us;
  }
}
