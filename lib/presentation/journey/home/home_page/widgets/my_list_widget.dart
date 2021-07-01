import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';

import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/home/home_page/home_page_constants.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/group_widget.dart';
import 'package:ghichu/presentation/journey/widgets/icon_widget.dart';

class MyListWidget extends StatelessWidget {
  int index;
  String keyGroup;
  String title;
  HomePageState state;
  int leght = 0;
  SlidableController slidableController;
  String color;
  MyListWidget(
      {Key key,
      this.slidableController,
      this.index,
      this.title,
      this.leght,
      this.color,
      this.keyGroup,
      this.state})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
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
          controller: slidableController,
          key: Key(title),
          actionPane: SlidableBehindActionPane(),
          child: GroupWidget(
              leght: leght,
              state: state,
              index: index,
              keyGroup: keyGroup,
              title: title,
              color: color),
          secondaryActions: secondaryActionsWidget(context)),
    );
  }

  List<Widget> secondaryActionsWidget(BuildContext context) {
    return List.generate(state.isEdit ? 2 : 1, (index1) {
      if (index1 == 0 && state.isEdit) {
        return GestureDetector(
          onTap: () {
            BlocProvider.of<HomePageBloc>(context).add(EditGroupEvent(index));
          },
          child: Container(
            color: Colors.grey,
            height: double.infinity,
            child: Icon(
              Icons.error,
              color: Colors.white,
              size: ScreenUtil().setSp(30),
            ),
          ),
        );
      }
      return GestureDetector(
        onTap: () {
          BlocProvider.of<HomePageBloc>(context)
              .add(DeleteGroupEvent(index: index, isDialog: false));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.only(
                topRight: index == 0
                    ? HomePageConstants.radiusCircle15
                    : Radius.circular(0),
                bottomRight: index == state.keyMyList.length - 1
                    ? HomePageConstants.radiusCircle15
                    : Radius.circular(0),
              )),
          height: double.infinity,
          child: Icon(
            Icons.delete,
            color: Colors.white,
            size: ScreenUtil().setSp(30),
          ),
        ),
      );
    });
  }
}
