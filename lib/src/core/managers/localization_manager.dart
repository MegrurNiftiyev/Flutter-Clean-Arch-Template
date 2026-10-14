import 'dart:ui';

import '../enums/app_region.dart';
import '../enums/language_code.dart';
import '../extensions/language_code_extensions.dart';

class LocalizationManager {
  const LocalizationManager();

  LanguageCode getSystemLanguage() {
    final systemLang = PlatformDispatcher.instance.locale.languageCode;
    return LanguageCode.fromCode(systemLang);
  }

  AppRegion getSystemRegion([LanguageCode? language]) {
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
    return targetLang.defaultRegion;
  }

  AppRegion getRegionForLanguage(LanguageCode language) {
    return language.defaultRegion;
  }
}
