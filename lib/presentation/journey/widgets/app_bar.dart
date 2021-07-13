import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';

import 'package:ghichu/presentation/journey/home/home_page/home_page_constants.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Function leading;
  final Function actions;
  final String textLeft;
  final String title;
  final String textRight;
  final Color color;
  final double heightAppbar;
  const AppBarWidget(
      {Key key,
      this.leading,
      this.actions,
      this.textLeft,
      this.title,
      this.textRight,
      this.color,
      this.heightAppbar,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: Center(
          child: GestureDetector(
        onTap: leading,
        child: Text(
          textLeft,
          style:
              TextStyle(color: Colors.blue, fontSize: ScreenUtil().setSp(16)),
        ),
      )),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontSize: ScreenUtil().setSp(20)),
      ),
      actions: [
        Center(
            child: GestureDetector(
          onTap: actions,
          child: Text(
            textRight,
            style: TextStyle(
                color: color,
                fontWeight: FontWeight.w600,
                fontSize: HomePageConstants.screenUtileSp18),
          ),
        )),
        SizedBox(
          width: HomePageConstants.paddingWidth10,
        ),
      ],
    );
  }
  @override
  Size get preferredSize => Size(double.infinity, heightAppbar==null?64:heightAppbar);
}
