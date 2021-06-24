import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/common/constants/route_constants.dart';

class HomePageConstants {
  static String reminderTodayTxt = 'Today';
  static String reminderAllTxt = 'All';
  static String reminderScheduledTxt = 'Scheduled';
  static IconData reminderTodayIcon = Icons.calendar_today;
  static IconData reminderAllIcon = Icons.all_inbox;
  static IconData reminderScheduledIcon = Icons.calendar_today;
  static Color reminderTodayColor = Colors.blue;
  static Color reminderAllColor = Colors.deepPurple;
  static Color reminderScheduledColor = Colors.red;
  static String myListTxt = 'My Lists';
  static String editTxt = 'Edit';
  static String doneTxt = 'Done';
  static String addListTxt = 'Add List';
  static String newReminderTxt = 'New Reminder';
  static double widthGroupText270 = ScreenUtil().setWidth(270);
  static double widthContainer = ScreenUtil().setWidth(30);
  static double heightContainer = ScreenUtil().setHeight(110);
  static double paddingWidth10 = ScreenUtil().setWidth(10);
  static double paddingWidth15 = ScreenUtil().setWidth(15);
  static double paddingWidth20 = ScreenUtil().setWidth(19);
  static double paddingHeight20 = ScreenUtil().setHeight(20);
  static double paddingHeight10 = ScreenUtil().setHeight(10);
  static Radius radiusCircle15 = Radius.circular(ScreenUtil().setSp(15));
  static Duration durationContainer = Duration(milliseconds: 180);
  static double screenUtileSp18 = ScreenUtil().setSp(18);
  static double screenUtileSp20 = ScreenUtil().setSp(20);
  static double screenUntilHeight60 = ScreenUtil().setHeight(60);
}
