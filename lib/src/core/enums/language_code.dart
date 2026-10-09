enum LanguageCode {
  en('en', 'English'),
  az('az', 'Azərbaycan'),
  tr('tr', 'Türkçe'),
  ru('ru', 'Русский'),
  es('es', 'Español'),
  de('de', 'Deutsch'),
  fr('fr', 'Français'),
  ar('ar', 'العربية');

  final String code;
  final String displayName;

  const LanguageCode(this.code, this.displayName);

  static LanguageCode fromCode(String code) {
    return LanguageCode.values.firstWhere(
      (lang) => lang.code.toLowerCase() == code.toLowerCase(),
      orElse: () => LanguageCode.en,
    );
  }
}
