import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CreateReminderConstants {
  static String detailsSwitchDate = 'Date';
  static String detailsSwitchTime = 'Time';
  static double detailsSwitchSizeIcon = ScreenUtil().setWidth(25);
  static var detailsIcon = Icons.calendar_today_rounded;
  static double sizeIcon = ScreenUtil().setSp(16);
  static double heightContainer = ScreenUtil().setHeight(55);
  static TextStyle textStyleDate =
      TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(15));
  static TextStyle textStyleTimer =
      TextStyle(color: Colors.blue, fontSize: ScreenUtil().setSp(15));
  static double heightSwitch = ScreenUtil().setHeight(30);
  static double witdhSwitch = ScreenUtil().setWidth(45);
  static double toggleSizeSwitch = ScreenUtil().setHeight(20);
  static double borderRadiusSwitch = ScreenUtil().setHeight(20);
}
