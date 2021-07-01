import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class AddListConstants {
  static List<Color> listColors = [
    Colors.red,
    Colors.deepOrangeAccent,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.purple,
    Colors.brown
  ];
  static double sizeContainer=ScreenUtil().setWidth(100);
  static double screenUntilHeight30=ScreenUtil().setHeight(30);
  static double sizeIcon=ScreenUtil().setSp(75);
  static BorderRadius radiusCircle10=BorderRadius.circular(ScreenUtil().setSp(10));
  static double screenUtilText=ScreenUtil().setSp(23);
  static double sizeContainerColor=ScreenUtil().setWidth(50);
  static double paddingWith=ScreenUtil().setWidth(10);
  static double paddingWith50=ScreenUtil().setWidth(50);
  static double paddingHeight10=ScreenUtil().setHeight(10);
}
