import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghichu/presentation/journey/reminder/reminder_constants.dart';
import 'package:intl/intl.dart';

class SelectContainer extends StatelessWidget {
  String title;
  String group;
  Function onTap;
  String color;
  bool buttonDetails;
  String timeDetails;
  SelectContainer(
      {Key key,
      this.title,
      this.group,
      this.onTap,
      this.color,
      this.timeDetails,
      this.buttonDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: ReminderContants.marginTop),
        height: ReminderContants.heightContanier,
        width: double.infinity,
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(9))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: ReminderContants.fontSize,
                  ),
                ),
                buttonDetails
                    ? Text('$timeDetails',
                        style: TextStyle(
                            color: Colors.black87.withOpacity(0.6),
                            fontSize: ScreenUtil().setSp(14)))
                    : SizedBox(),
              ],
            ),
            Row(
              children: [
                Visibility(
                  visible: group == null ? false : true,
                  child: Row(
                    children: [
                      color == null
                          ? SizedBox()
                          : Container(
                              width: ReminderContants.sizeColorGroup,
                              height: ReminderContants.sizeColorGroup,
                              decoration: BoxDecoration(
                                  color: Color(int.parse(color)),
                                  shape: BoxShape.circle),
                            ),
                      SizedBox(
                        width: ReminderContants.paddingWitdh,
                      ),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: ScreenUtil().setWidth(200)),
                        child: Text(
                          group == null ? '' : group,
                          style: TextStyle(
                              color: Colors.black45,
                              fontSize: ReminderContants.fontSizeGroup),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )
                    ],
                  ),
                ),
                Icon(
                  Icons.navigate_next_outlined,
                  size: ReminderContants.sizeIconContinue,
                  color: Colors.black45,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
