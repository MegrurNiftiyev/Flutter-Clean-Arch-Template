enum AppLanguage {
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

  const AppLanguage(this.code, this.displayName);

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (lang) => lang.code.toLowerCase() == code.toLowerCase(),
      orElse: () => AppLanguage.en,
    );
  }
}
