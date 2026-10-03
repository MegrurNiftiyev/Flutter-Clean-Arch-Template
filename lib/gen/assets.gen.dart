// dart format width=80

/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: deprecated_member_use,directives_ordering,implicit_dynamic_list_literal,unnecessary_import

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Inter-Bold.ttf
  String get interBold => 'assets/fonts/Inter-Bold.ttf';

  /// File path: assets/fonts/Inter-Medium.ttf
  String get interMedium => 'assets/fonts/Inter-Medium.ttf';

  /// File path: assets/fonts/Inter-Regular.ttf
  String get interRegular => 'assets/fonts/Inter-Regular.ttf';

  /// File path: assets/fonts/Inter-SemiBold.ttf
  String get interSemiBold => 'assets/fonts/Inter-SemiBold.ttf';

  /// List of all assets
  List<String> get values =>
      [interBold, interMedium, interRegular, interSemiBold];
}

class $AssetsLangGen {
  const $AssetsLangGen();

  /// File path: assets/lang/ar.json
  String get ar => 'assets/lang/ar.json';

  /// File path: assets/lang/az.json
  String get az => 'assets/lang/az.json';

  /// File path: assets/lang/de.json
  String get de => 'assets/lang/de.json';

  /// File path: assets/lang/en.json
  String get en => 'assets/lang/en.json';

  /// File path: assets/lang/es.json
  String get es => 'assets/lang/es.json';

  /// File path: assets/lang/fr.json
  String get fr => 'assets/lang/fr.json';

  /// File path: assets/lang/ru.json
  String get ru => 'assets/lang/ru.json';

  /// File path: assets/lang/tr.json
  String get tr => 'assets/lang/tr.json';

  /// List of all assets
  List<String> get values => [ar, az, de, en, es, fr, ru, tr];
}

abstract final class Assets {
  static const String aEnv = '.env';
  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsLangGen lang = $AssetsLangGen();

  /// List of all assets
  static List<String> get values => [aEnv];
}
