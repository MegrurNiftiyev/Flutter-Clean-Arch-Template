import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppPaddings {
  static EdgeInsets get zero => EdgeInsets.zero;
  static EdgeInsets get all4 => EdgeInsets.all(4.r);
  static EdgeInsets get all8 => EdgeInsets.all(8.r);
  static EdgeInsets get all12 => EdgeInsets.all(12.r);
  static EdgeInsets get all16 => EdgeInsets.all(16.r);
  static EdgeInsets get all24 => EdgeInsets.all(24.r);

  static EdgeInsets get h4 => EdgeInsets.symmetric(horizontal: 4.w);
  static EdgeInsets get h8 => EdgeInsets.symmetric(horizontal: 8.w);
  static EdgeInsets get h16 => EdgeInsets.symmetric(horizontal: 16.w);
  static EdgeInsets get h24 => EdgeInsets.symmetric(horizontal: 24.w);

  static EdgeInsets get v8 => EdgeInsets.symmetric(vertical: 8.h);
  static EdgeInsets get v14 => EdgeInsets.symmetric(vertical: 14.h);
  static EdgeInsets get v16 => EdgeInsets.symmetric(vertical: 16.h);
  static EdgeInsets get v24 => EdgeInsets.symmetric(vertical: 24.h);

  static EdgeInsets get page => EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h);
  static EdgeInsets get inputContent => EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h);
  static EdgeInsets get buttonContent => EdgeInsets.symmetric(horizontal: 16.w);
}
