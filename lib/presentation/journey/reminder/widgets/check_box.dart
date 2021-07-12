

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class CheckBoxWidget extends StatelessWidget {
final String priorty;

   CheckBoxWidget({Key key, this.priorty}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: ScreenUtil().setWidth(25),
      height: ScreenUtil().setWidth(25),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black38),
          shape: BoxShape.circle),
      child: Text(priority(priorty),style: TextStyle(color: Colors.black38,fontSize: ScreenUtil().setSp(20),fontWeight: FontWeight.bold),)
    );
  }
  String priority(String prior){
 
    switch(prior){
      case 'Không có':
        return "0";
      case 'Thấp':
        return "1";
      case 'Trung bình':
        return "2";
      case 'Cao':
        return "3";
    }
  }
}
