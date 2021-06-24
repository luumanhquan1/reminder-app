import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

class CheckBoxWidget extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {

        },
        child: Container(
          width: ScreenUtil().setWidth(25),
          height: ScreenUtil().setWidth(25),
          padding: EdgeInsets.all(2),
          decoration: BoxDecoration(
              border: Border.all(width: 1.2, color: Colors.black38),
              shape: BoxShape.circle),
          child: Container(
            decoration: BoxDecoration(
                color:  Colors.transparent,
                shape: BoxShape.circle),
          ),
        ));
  }
}
