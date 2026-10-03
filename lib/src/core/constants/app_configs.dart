import 'package:flutter/material.dart';
import 'fonts.dart';

abstract class AppConfigs {
  static const Size designSize = Size(375, 812);
  static const String fontFamily = AppFonts.fontFamily;
  static const String langPath = 'assets/lang';
  static const Locale fallbackLocale = Locale('en');
  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('az'),
    Locale('tr'),
    Locale('ru'),
    Locale('es'),
    Locale('de'),
    Locale('fr'),
    Locale('ar'),
  ];
}
