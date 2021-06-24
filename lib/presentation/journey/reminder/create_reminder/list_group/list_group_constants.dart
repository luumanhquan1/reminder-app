import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class ListGroupConstants {
  static String titleTxt = 'Danh sách';
  static double paddingWitdh10 = ScreenUtil().setWidth(10);
  static double paddingWitdh30 = ScreenUtil().setWidth(30);
  static double paddingHeight10=ScreenUtil().setHeight(10);
  static double heightContainer = ScreenUtil().setHeight(60);
  static double sizeIcon=ScreenUtil().setWidth(30);
  static String appBarLeadingTxt = 'Lời nhắc mới';
  static TextStyle textStyleAppBarTitle =
      TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(18));
  static TextStyle textStyleLeadingTxt =
      TextStyle(color: Colors.blue, fontSize: ScreenUtil().setSp(15));
  static TextStyle titleGroup=TextStyle(
      color: Colors.black,
      fontSize: ScreenUtil().setSp(16));
}
