import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_event.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/add_widget.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/list_reminder.dart';
import 'package:sticky_headers/sticky_headers.dart';

class StickyReminderSchedule extends StatelessWidget {
  final String header;
  final String color;
  final List<ReminderEntity> listReminder;
  final GroupEntity groupEntity;
  final List<GroupEntity> listGroup;
  final int indexGroup;
  InitManagerReminderState state;
  SlidableController slidableController;

  StickyReminderSchedule(
      {Key key,
      @required this.state,
      @required this.listGroup,
      @required this.groupEntity,
      @required this.slidableController,
      @required this.header,
      @required this.color,
      @required this.listReminder,
      this.indexGroup})
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
                    selectReminder: () {
                      BlocProvider.of<ManageReminderBloc>(context).add(
                          SelectReminderEvent(
                              indexReminder: index, indexGroup: indexGroup));
                    },
                    editReminderBtn: () {
                      BlocProvider.of<ManageReminderBloc>(context).add(
                          EditReminderEvent(
                              group: listReminder[index].list,
                              reminderEntity: listReminder[index]));
                    },
                    deleleReminderBtn: () {
                      BlocProvider.of<ManageReminderBloc>(context).add(
                          DeleteReminderEvent(
                              reminderEntity: listReminder[index],
                              index: index));
                    },
                    state: state,
                    indexReminder: index,
                    indexGroup: indexGroup,
                    slidableController: slidableController,
                    title: listReminder[index].title,
                    note: listReminder[index].note,
                    group: listReminder[index].list,
                    time: listReminder[index].details.time ?? '',
                  );
                }),
              ),
              AddWidget(
                state: state,
                index: indexGroup,
                keyGroup: header,
              ),
            ],
          )),
    );
  }
}
