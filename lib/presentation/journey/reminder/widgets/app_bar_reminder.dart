import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/presentation/journey/home/home_page/home_page_constants.dart';
import 'package:ghichu/presentation/journey/reminder/reminder_constants.dart';

class AppBarReminderWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final Function leading;
  final Function actions;
  final String textLeft;
  final String title;
  final Widget textRight;
  bool isIconEdit;
  AppBarReminderWidget(
      {Key key,
      this.isIconEdit,
      this.leading,
      this.actions,
      this.textLeft,
      this.title,
      this.textRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Center(
          child: GestureDetector(
              onTap: leading == null
                  ? () {
                      Navigator.pop(context);
                    }
                  : leading,
              child: Row(
                children: [
                  Icon(Icons.arrow_back_ios_rounded,
                      color: Colors.blue, size: ScreenUtil().setSp(21)),
                  textLeft == null
                      ? Text(
                          ReminderContants.listTxt,
                          style: ReminderContants.textStyleLeading,
                        )
                      : Text(
                          textLeft,
                          style: ReminderContants.textStyleLeading,
                        )
                ],
              ))),
      leadingWidth: ScreenUtil().setWidth(150),
      centerTitle: true,
      title: title == null
          ? SizedBox()
          : Text(
              title,
              style: ReminderContants.textStyleTitleAppBar,
            ),
      actions: [
        Center(
          child: GestureDetector(
              onTap: actions,
              child: textRight == null
                  ? isIconEdit
                      ? Text(
                          'Xong',
                          style: ReminderContants.textStyleLeading,
                        )
                      : Icon(
                          Icons.segment,
                          color: ReminderContants.colorIcon,
                          size: ReminderContants.sizeIcon,
                        )
                  : textRight),
        ),
        SizedBox(
          width: HomePageConstants.paddingWidth10,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size(double.infinity, 60);
}
