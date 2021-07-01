import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/home/home_page/home_page_constants.dart';
import 'package:ghichu/presentation/journey/widgets/icon_widget.dart';

class EditWidget extends StatelessWidget {
  InitHomePageState state;
  EditWidget({Key key, this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !state.isEdit,
      maintainAnimation: true,
      maintainState: true,
      child: AnimatedOpacity(
        opacity: !state.isEdit ? 1 : 0,
        duration: HomePageConstants.durationContainer,
        child: Container(
          margin: EdgeInsets.only(top: ScreenUtil().setHeight(20)),
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().setHeight(180),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: ReorderableListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(state.reminderSystem.length, (index) {
                if (state.reminderSystem[index] == 'Today') {
                  return group(
                      index: index,
                      iconData: HomePageConstants.reminderTodayIcon,
                      color: HomePageConstants.reminderTodayColor,
                      name: HomePageConstants.reminderTodayTxt);
                }
                if (state.reminderSystem[index] == 'Scheduled') {
                  return group(
                      index: index,
                      iconData: HomePageConstants.reminderScheduledIcon,
                      color: HomePageConstants.reminderScheduledColor,
                      name: HomePageConstants.reminderScheduledTxt);
                }
                if (state.reminderSystem[index] == 'All') {
                  return group(
                      index: index,
                      iconData: HomePageConstants.reminderAllIcon,
                      color: HomePageConstants.reminderAllColor,
                      name: HomePageConstants.reminderAllTxt);
                }
                return SizedBox();
              }),
              onReorder: (int oldIndex, int newIndex) {
                if (oldIndex < newIndex) {
                  newIndex = newIndex - 1;
                }
                BlocProvider.of<HomePageBloc>(context)
                    .add(OrderGroupSystemEvent(
                  newIndex: newIndex,
                  oldIndex: oldIndex,
                ));
              }),
        ),
      ),
    );
  }

  // Row(
  // key: Key('$index'),
  // children: [
  // SizedBox(
  // width: HomePageConstants.paddingWidth10,
  // ),
  // IconWidget(
  // icon: HomePageConstants.list[index]['icons'],
  // shadow: 0,
  // color:
  // Color(HomePageConstants.list[index]['colors'].value),
  // colorGraient:
  // Color(HomePageConstants.list[index]['colors'].value),
  // ),
  // SizedBox(
  // width: ScreenUtil().setWidth(10),
  // ),
  // Expanded(
  // child: Container(
  // key: Key('$index'),
  // height: ScreenUtil().setHeight(50),
  // margin:
  // EdgeInsets.only(top: ScreenUtil().setHeight(10)),
  // alignment: Alignment.centerLeft,
  // decoration: BoxDecoration(
  // color: Colors.transparent,
  // border: Border(
  // bottom: BorderSide(
  // color: index == 2
  // ? Colors.transparent
  //     : Colors.black26))),
  // child: Row(
  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
  // children: [
  // Text(
  // "${HomePageConstants.list[index]['title']}",
  // style: TextStyle(
  // color: Colors.black,
  // fontWeight: FontWeight.w400,
  // fontSize: ScreenUtil().setSp(13)),
  // ),
  // Padding(
  // padding: EdgeInsets.only(
  // right: ScreenUtil().setWidth(10)),
  // child: Icon(
  // Icons.list,
  // size: ScreenUtil().setSp(25),
  // color: Colors.black38,
  // ),
  // )
  // ],
  // )),
  // )
  // ],
  // )
  Widget group(
      {@required int index,
      @required IconData iconData,
      @required Color color,
      @required String name}) {
    return Row(
      key: Key('$index'),
      children: [
        SizedBox(
          width: HomePageConstants.paddingWidth10,
        ),
        IconWidget(
          icon: iconData,
          shadow: 0,
          color: color,
          colorGraient: color,
        ),
        SizedBox(
          width: ScreenUtil().setWidth(10),
        ),
        Expanded(
          child: Container(
              key: Key('$index'),
              height: ScreenUtil().setHeight(50),
              margin: EdgeInsets.only(top: ScreenUtil().setHeight(10)),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(
                      bottom: BorderSide(
                          color: index == 2
                              ? Colors.transparent
                              : Colors.black26))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(13)),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                    child: Icon(
                      Icons.list,
                      size: ScreenUtil().setSp(25),
                      color: Colors.black38,
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }
}
