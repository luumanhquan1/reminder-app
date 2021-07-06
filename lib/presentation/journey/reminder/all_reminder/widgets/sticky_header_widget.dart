import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/add_widget.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/list_reminder.dart';
import 'package:sticky_headers/sticky_headers.dart';

class StickyReminderAll extends StatelessWidget {
  final String header;
  final String color;
  final List<ReminderEntity> listReminder;
  const StickyReminderAll(
      {Key key, @required this.header, @required this.color,@required this.listReminder})
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
          header,
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
                children: List.generate(listReminder.length, (index) {
                  return ListReminder(
                    title: listReminder[index].title,
                    note: listReminder[index].note,
                    date: listReminder[index].details.date??'',
                    time: listReminder[index].details.time??'',
                  );
                }),
              ),
              AddWidget(
                keyGroup: header,
              ),
            ],
          )),
    );
  }
}
