import '../enums/app_region.dart';
import '../enums/language_code.dart';

extension LanguageCodeExtension on LanguageCode {
  AppRegion get defaultRegion {
    switch (this) {
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
