import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class ReminderContants {
  static double CircleGroup = ScreenUtil().setWidth(5);
  static double fontSize = ScreenUtil().setSp(16);
  static double sizeIconContinue = ScreenUtil().setSp(30);
  static double fontHineText = ScreenUtil().setSp(16);
  static double heightContanier = ScreenUtil().setHeight(60);
  static double marginTop = ScreenUtil().setHeight(25);
  static double sizeColorGroup = ScreenUtil().setSp(7);
  static double fontSizeGroup = ScreenUtil().setSp(16);
  static double paddingWitdh = ScreenUtil().setWidth(6);
  static Color colorIcon = Colors.blue;
  static double sizeIcon = ScreenUtil().setSp(20);
  static String titleHintTxt = 'Title';
  static String noteHintTxt = 'Notes';
  static String detailsTxt = 'Chi tiết';
  static String listTxt = 'Danh sách';
  static TextStyle textStyleLeading =
      TextStyle(color: Colors.blue, fontSize: ScreenUtil().setSp(15));
  static TextStyle textStyleTitleAppBar =
      TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(20));
  static TextStyle textStyleTitle =
      TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(16));
  static TextStyle textStyleNote =
      TextStyle(color: Colors.black54, fontSize: ScreenUtil().setSp(13));
  static TextStyle textStyleDateGroup=TextStyle(
      color: Colors.black54,
      fontSize: ScreenUtil().setSp(14));
  static TextStyle textStyleSchedule=TextStyle(
      color: Colors.red,
      fontSize: ScreenUtil().setSp(14));
}
