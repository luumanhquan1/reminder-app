import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/home/home_page/home_page_constants.dart';
import 'package:ghichu/presentation/journey/widgets/icon_widget.dart';

class MyListWidget extends StatelessWidget {
  int index;
  String keyGroup;
  String title;
  HomePageState state;
  int leght = 0;
  String color;
  MyListWidget(
      {Key key,
      this.index,
      this.title,
      this.leght,
      this.color,
      this.keyGroup,
      this.state})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 100,
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
          child: Slidable(
            actionExtentRatio: 0.25,
            child: getList(),
            secondaryActions: <Widget>[
              Container(
                height: 800,
                color: Colors.green,
                child: Text('a'),
              ),
              IconSlideAction(
                caption: 'More',
                color: Colors.grey.shade200,
                icon: Icons.more_horiz,

                closeOnTap: false,
              ),
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red,
                icon: Icons.delete,

              ),
            ],
          )
      ),
    );
  }
  Widget getList(){
    return Stack(
      children: [
        AnimatedPositioned(
          duration: Duration(seconds: 1),
          top: 0,
          bottom: 0,
          left: state.isEdit ? -25 : 15,
          child: GestureDetector(
            onTap: () {
              log('234');
            },
            child: Icon(
              Icons.do_not_disturb_on,
              color: Colors.red,
            ),
          ),
        ),
        AnimatedContainer(
          margin: EdgeInsets.only(left: state.isEdit ? 0 : 30),
          duration: Duration(seconds: 1),
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
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: HomePageConstants.paddingHeight20),
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
                        child: Container(
                          // width: HomePageConstants.widthGroupText270,
                          child: Text(
                            title,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: ScreenUtil().setSp(18)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              leght == null ? '0' : '$leght',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: ScreenUtil().setSp(16)),
                            )),
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
              ),
            ],
          ),
        )
      ],
    );
  }
}
