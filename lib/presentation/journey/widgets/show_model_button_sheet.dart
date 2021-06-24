import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

dynamic showButtonModalSheet(BuildContext context) {
  return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().setHeight(150),
          color: Colors.transparent,
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: ScreenUtil().setHeight(60),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'Hủy bỏ thay đổi',
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreenUtil().setSp(23)),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: ScreenUtil().setHeight(60),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Text(
                      'Hủy',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: ScreenUtil().setSp(23),
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}