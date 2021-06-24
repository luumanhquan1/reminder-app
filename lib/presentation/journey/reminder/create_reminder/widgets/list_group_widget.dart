import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/data/models/model_map.dart';
import 'package:ghichu/presentation/journey/home/home_page/home_page_constants.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/list_group/bloc/list_group_state.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/list_group/list_group_constants.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/priorities_screen/bloc/priority_state.dart';


// ignore: must_be_immutable
class ListGroupWidget extends StatelessWidget {
  String color;
  String title;
  int index;
  ListGroupState listGroupState;
  PriorityState priorityState;
  var state;
  bool isIcon;
  Function onTap;
  ListGroupWidget(
      {Key key,
      this.listGroupState,
      this.priorityState,
      this.isIcon,
      this.color,
      this.title,
      this.index,
      this.onTap})
      : super(key: key) {
    if (listGroupState == null) {
      state = priorityState;
    } else {
      state = listGroupState;
    }
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: isIcon ? Colors.transparent : Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: index == 0
                  ? HomePageConstants.radiusCircle15
                  : Radius.circular(0),
              topRight: index == 0
                  ? HomePageConstants.radiusCircle15
                  : Radius.circular(0),
              bottomLeft:
                  index == ModelListReminder.reminderApp['priorities'].length
                      ? HomePageConstants.radiusCircle15
                      : Radius.circular(0),
              bottomRight:
                  index == ModelListReminder.reminderApp['priorities'].length
                      ? HomePageConstants.radiusCircle15
                      : Radius.circular(0),
            )),
        child: Padding(
          padding: EdgeInsets.only(
              left: ListGroupConstants.paddingWitdh10,
              right: ListGroupConstants.paddingWitdh10),
          child: Row(
            children: [
              isIcon
                  ? Container(
                      width: ListGroupConstants.sizeIcon,
                      height: ListGroupConstants.sizeIcon,
                      decoration: BoxDecoration(
                          color: Color(int.parse(color)),
                          shape: BoxShape.circle),
                      child: Center(
                          child: Icon(
                        Icons.list,
                        color: Colors.white,
                        size: ScreenUtil().setSp(22),
                      )),
                    )
                  : SizedBox(),
              SizedBox(
                width: ScreenUtil().setWidth(15),
              ),
              Expanded(
                child: Container(
                    height: ScreenUtil().setHeight(55),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                color: isIcon
                                    ? Colors.black45
                                    : index == 0
                                        ? Colors.black
                                        : Colors.black45,
                                width: isIcon
                                    ? 0.3
                                    : index == 0
                                        ? 1
                                        : 0.3))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              '$title',
                              style: ListGroupConstants.titleGroup,
                            ),
                          ),
                        ),
                        index == state.indexCheck
                            ? Icon(
                                Icons.check_sharp,
                                color: Colors.blue,
                                size: ScreenUtil().setSp(22),
                              )
                            : SizedBox()
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
