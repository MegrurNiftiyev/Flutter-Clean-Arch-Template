import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppRadii {
  static double get r4 => 4.r;
  static double get r8 => 8.r;
  static double get r12 => 12.r;
  static double get r16 => 16.r;
  static double get r24 => 24.r;

  static BorderRadius get borderR4 => BorderRadius.circular(4.r);
  static BorderRadius get borderR8 => BorderRadius.circular(8.r);
  static BorderRadius get borderR12 => BorderRadius.circular(12.r);
  static BorderRadius get borderR16 => BorderRadius.circular(16.r);
  static BorderRadius get borderR24 => BorderRadius.circular(24.r);
}
