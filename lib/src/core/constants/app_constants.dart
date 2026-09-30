import 'package:flutter/material.dart';

abstract class AppConstants {
  static const String langPath = 'assets/lang';
  static const Locale fallbackLocale = Locale('en');
  static const List<Locale> supportedLocales = [
    Locale('en'),
  ];
}
