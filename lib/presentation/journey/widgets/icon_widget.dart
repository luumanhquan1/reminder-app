import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class IconWidget extends StatelessWidget {
  var icon;
  Color color;
  double size = ScreenUtil().setWidth(35);
  double sizeIcon = ScreenUtil().setSp(25);
  double shadow=0;
  Color colorGraient;
  IconWidget(
      {Key key,
      this.color,
      this.icon,
      this.size,
      this.sizeIcon,
      this.colorGraient,
      this.shadow})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setHeight(5)),
      padding: EdgeInsets.all(ScreenUtil().setSp(6)),
      width: size,
      height: size,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [colorGraient, color]),
          boxShadow: [
            BoxShadow(
                color:shadow==0?Colors.black.withOpacity(0):Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 0,
                offset: Offset(0, 5))
          ]),
      child: Icon(icon, color: Colors.white, size: sizeIcon),
    );
  }
}
