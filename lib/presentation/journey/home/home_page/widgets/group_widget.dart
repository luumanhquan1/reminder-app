import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/reminder/reminder_constants.dart';
import 'package:ghichu/presentation/journey/widgets/icon_widget.dart';

import '../home_page_constants.dart';

class GroupWidget extends StatelessWidget {
  final HomePageState state;
  final int index;
  final String keyGroup;
  final String title;
  final int leght;
  final String color;

  const GroupWidget(
      {Key key,
      @required this.state,
        @required this.leght,
      @required this.index,
      @required this.keyGroup,
      @required this.title,
      @required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.isOpen) {
      Slidable.of(context)?.close();
    }
    return Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: index == 0
                ? HomePageConstants.radiusCircle15
                : Radius.circular(0),
            topRight: index == 0
                ? HomePageConstants.radiusCircle15
                : Radius.circular(0),
            bottomLeft: index == state.keyMyList.length - 1
                ? HomePageConstants.radiusCircle15
                : Radius.circular(0),
            bottomRight: index == state.keyMyList.length - 1
                ? HomePageConstants.radiusCircle15
                : Radius.circular(0),
          )),
      child: Stack(
        children: [
          editGroupWidget(context),
          AnimatedContainer(
            margin: EdgeInsets.only(left: state.isEdit ? 0 : 40),
            duration: HomePageConstants.durationEdit,
            child: Row(
              children: [
                SizedBox(
                  width: HomePageConstants.paddingWidth10,
                ),
                IconWidget(
                  icon: Icons.list,
                  shadow: 0,
                  colorGraient: Color(int.parse(color)),
                  color: Color(int.parse(color)),
                ),
                SizedBox(
                  width: HomePageConstants.paddingWidth10,
                ),
                inforGroup(context)
              ],
            ),
          )
        ],
      ),
    );
  }

  Expanded inforGroup(BuildContext context) {
    return Expanded(
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: HomePageConstants.paddingHeight20),
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    color: index == state.keyMyList.length - 1
                        ? Colors.transparent
                        : Colors.black12))),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: GestureDetector(
                onTap: () {
                  Slidable.of(context).open();
                  Slidable.of(context)?.close();
                },
                child: Container(
                  // width: HomePageConstants.widthGroupText270,
                  child: Text(
                    title,
                    style: TextStyle(
                        color: Colors.black, fontSize: ScreenUtil().setSp(18)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerRight,
                child: state.isEdit
                    ? Text(
                        leght == null ? '0' : '$leght',
                        style: TextStyle(
                            color: Colors.black54,
                            fontSize: ScreenUtil().setSp(16)),
                      )
                    : Icon(
                        Icons.error_outline,
                        size: ScreenUtil().setSp(25),
                        color: ReminderContants.colorIcon,
                      ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(
                Icons.navigate_next_outlined,
                color: Colors.black26,
                size: ScreenUtil().setSp(20),
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(5),
            )
          ],
        ),
      ),
    );
  }

  AnimatedPositioned editGroupWidget(BuildContext context) {
    return AnimatedPositioned(
      duration: HomePageConstants.durationEdit,
      top: 0,
      bottom: 0,
      left: state.isEdit ? -25 : 13,
      child: GestureDetector(
        onTap: () {
          Slidable.of(context).open(actionType: SlideActionType.secondary);
        },
        child: Icon(
          Icons.do_not_disturb_on,
          color: Colors.red,
        ),
      ),
    );
  }
}
