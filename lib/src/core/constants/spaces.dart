import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppSpaces {
  // Spacing double values
  static double get s2 => 2.r;
  static double get s4 => 4.r;
  static double get s8 => 8.r;
  static double get s12 => 12.r;
  static double get s16 => 16.r;
  static double get s20 => 20.r;
  static double get s24 => 24.r;
  static double get s32 => 32.r;
  static double get s40 => 40.r;
  static double get s48 => 48.r;
  static double get s64 => 64.r;

  // Vertical Spacers (height)
  static SizedBox get v4 => SizedBox(height: 4.h);
  static SizedBox get v8 => SizedBox(height: 8.h);
  static SizedBox get v12 => SizedBox(height: 12.h);
  static SizedBox get v16 => SizedBox(height: 16.h);
  static SizedBox get v20 => SizedBox(height: 20.h);
  static SizedBox get v24 => SizedBox(height: 24.h);
  static SizedBox get v32 => SizedBox(height: 32.h);
  static SizedBox get v40 => SizedBox(height: 40.h);
  static SizedBox get v48 => SizedBox(height: 48.h);
  static SizedBox get v64 => SizedBox(height: 64.h);

  // Horizontal Spacers (width)
  static SizedBox get h4 => SizedBox(width: 4.w);
  static SizedBox get h8 => SizedBox(width: 8.w);
  static SizedBox get h12 => SizedBox(width: 12.w);
  static SizedBox get h16 => SizedBox(width: 16.w);
  static SizedBox get h20 => SizedBox(width: 20.w);
  static SizedBox get h24 => SizedBox(width: 24.w);
  static SizedBox get h32 => SizedBox(width: 32.w);
  static SizedBox get h40 => SizedBox(width: 40.w);
  static SizedBox get h48 => SizedBox(width: 48.w);
}
