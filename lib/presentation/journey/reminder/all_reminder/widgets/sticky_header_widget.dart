import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghichu/data/models/model_map.dart';
import 'package:ghichu/data/models/reminder.dart';

import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
import 'package:ghichu/presentation/journey/reminder/all_reminder/bloc/all_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/list_reminder.dart';

import 'package:sticky_headers/sticky_headers.dart';
import '../../widgets/add_widget.dart';

class StickyReminderAll extends StatelessWidget {
  String header;
  Map<String, List<Reminder>> listReminderAll;
  String keyGroup;
  String color;
  int indexHeader, indexReminder;
  AllReminderBloc allReminderBloc;

  Map<String, TextFiledController> controller;
  StickyReminderAll(
      {Key key,
      this.allReminderBloc,
      this.listReminderAll,
      this.keyGroup,
      this.header,
      this.color,
      this.controller,
      this.indexHeader,
      this.indexReminder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StickyHeader(
      header: Container(
        padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
        height: ScreenUtil().setHeight(50),
        width: ScreenUtil().screenWidth,
        color: Colors.white,
        alignment: Alignment.centerLeft,
        child: Text(
          ModelListReminder.myList['$header'].title,
          style: TextStyle(
              color: Color(int.parse(color)),
              fontWeight: FontWeight.w700,
              fontSize: ScreenUtil().setSp(25)),
        ),
      ),
      content: Container(
          width: ScreenUtil().screenWidth,
          color: Colors.transparent,
          child: Column(
            children: [
              Column(
                children: List.generate(listReminderAll.values.length, (index) {
                  List<Reminder> reminder =
                      listReminderAll.values.elementAt(index);
                  return Column(
                    children: List.generate(reminder.length, (index1) {
                      indexReminder = indexReminder + 1;
                      return ListReminder(
                        keyGroup: keyGroup,
                        controller: controller,
                        allReminderBloc: allReminderBloc,
                        indexGroup: indexHeader,
                        indexReminder: indexReminder,
                        title: reminder[index1].title,
                        note: reminder[index1].note,
                        date: reminder[index1].date,
                        time: reminder[index1].time,
                      );
                    }),
                  );
                }),
              ),
              AddWidget(
                allReminderBloc: allReminderBloc,
                index: indexHeader,
                keyGroup: header,
                controller: controller,
              ),
            ],
          )),
    );
  }
}
