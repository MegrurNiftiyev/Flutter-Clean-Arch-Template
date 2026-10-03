enum AppRegion {
  us('US', 'United States'),
  az('AZ', 'Azerbaijan'),
  tr('TR', 'Turkey'),
  ru('RU', 'Russia'),
  es('ES', 'Spain'),
  de('DE', 'Germany'),
  fr('FR', 'France'),
  sa('SA', 'Saudi Arabia');

  final String code;
  final String displayName;

  const AppRegion(this.code, this.displayName);

  static AppRegion fromCode(String code) {
    return AppRegion.values.firstWhere(
      (region) => region.code.toUpperCase() == code.toUpperCase(),
      orElse: () => AppRegion.us,
    );
  }
}
