import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ghichu/data/models/reminder.dart';
import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';
import 'package:ghichu/presentation/journey/reminder/reminder_constants.dart';

import 'package:ghichu/presentation/journey/reminder/widgets/check_box.dart';

class ListReminder extends StatelessWidget {
  String title, group, note, date, time,priorty;
  int createAt;
  Map<String, TextFiledController> controller;
  Reminder reminder;
  SlidableController slidableController;
  int indexReminder, indexGroup, index;
  InitManagerReminderState state;
  final Function editReminderBtn;
  final Function deleleReminderBtn;
  final Function selectReminder;
  ListReminder(
      {Key key,
      @required this.slidableController,
      @required this.deleleReminderBtn,
      @required this.editReminderBtn,
      @required this.selectReminder,
        @required this.state,
      this.title,
        this.priorty,
      this.time,
      this.indexReminder,
      this.group,
      this.note,
      this.date,
      this.indexGroup,
      this.controller,
      this.createAt,
      this.reminder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(title),
      controller: slidableController,
      actionPane: SlidableBehindActionPane(),
      secondaryActions: [
        SlideAction(
            onTap: editReminderBtn,
            child: Container(
              color: Colors.grey,
              child: Center(
                  child: Text(
                'Chi tiết',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(17)),
              )),
            )),
        SlideAction(
          onTap: deleleReminderBtn,
          child: Container(
            color: Colors.red,
            child: Center(
                child: Text(
              'Xóa',
              style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(17)),
            )),
          ),
        )
      ],
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
          child: Row(
            children: [
              // Icon(Icons.check_circle_outlined),
              // CheckBoxWidget(priorty:priorty,),
              SizedBox(
                width: ScreenUtil().setWidth(7),
              ),
              Expanded(
                  child: GestureDetector(
                onTap:selectReminder,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(10)),
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black26))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width:indexReminder==state.indexReminder?ScreenUtil().setWidth(320):ScreenUtil().setWidth(355),
                            child: Text(
                              '$title',
                              style: ReminderContants.textStyleTitle,
                            ),
                          ),
                          group != null
                              ? Row(
                                  children: [
                                    Text(
                                      time == ''
                                          ? "$group"
                                          : "$group - ${time.replaceAll('-', ':')}",
                                      style:
                                          ReminderContants.textStyleDateGroup,
                                    ),
                                  ],
                                )
                              : Visibility(
                                  visible: date == '' ? false : true,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: ScreenUtil().setHeight(5),
                                      ),
                                      Text(
                                        time == ''
                                            ? "$date"
                                            : "${time.replaceAll('-', ':')},$date",
                                        style:
                                            ReminderContants.textStyleDateGroup,
                                      ),
                                    ],
                                  )),
                          Visibility(
                              visible: note == '' ? false : true,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(7),
                                  ),
                                  Container(
                                    width:indexReminder==state.indexReminder?ScreenUtil().setWidth(320):ScreenUtil().setWidth(355),

                                    child: Text(
                                      '$note',
                                      style: ReminderContants.textStyleNote,
                                    ),
                                  )
                                ],
                              )),
                          SizedBox(
                            height: ScreenUtil().setHeight(5),
                          )
                        ],
                      ),

                      Padding(
                        padding:  EdgeInsets.only(right: ScreenUtil().setWidth(12)),
                        child: Visibility(
                            visible: indexGroup == state.indexGroup
                                ? indexReminder == state.indexReminder
                                ? true
                                : false
                                : false,
                            child: GestureDetector(
                              onTap: editReminderBtn,
                              child: Icon(
                                Icons.error_outline,
                                size: ScreenUtil().setSp(25),
                                color: ReminderContants.colorIcon,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
