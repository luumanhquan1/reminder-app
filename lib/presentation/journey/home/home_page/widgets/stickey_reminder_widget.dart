import 'dart:developer';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghichu/domain/entities/details_entity.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_event.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/add_widget.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/list_reminder.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

// ignore: must_be_immutable
class StickyReminderSearch extends StatelessWidget {
  final String header;
  final String color;
  final int indexGroup;
  final List<ReminderEntity> listReminder;
  final List<GroupEntity> listGroup;
  final GroupEntity groupEntity;
  InitManagerReminderState state;
  SlidableController slidableController;
  StickyReminderSearch(
      {Key key,
        @required this.slidableController,
        @required this.indexGroup,
        @required this.header,
        @required this.color,
        @required this.listReminder,
        @required this.listGroup,
        @required this.groupEntity,
        @required this.state})
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
          overflow: TextOverflow.ellipsis,
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
                      BlocProvider.of<ManageReminderBloc>(context).add(AddReminderEvent());
                    },
                    editReminderBtn: () {
                      BlocProvider.of<ManageReminderBloc>(context).add(
                          EditReminderEvent(
                              group: header,
                              reminderEntity: listReminder[index]));
                    },
                    deleleReminderBtn: () {
                      BlocProvider.of<ManageReminderBloc>(context).add(
                          DeleteReminderEvent(
                              reminderEntity: listReminder[index],
                              index: index));
                    },
                    slidableController: slidableController,
                    indexGroup: indexGroup,
                    indexReminder: index,
                    title: listReminder[index].title,
                    note: listReminder[index].note,
                    priorty: listReminder[index].details.priority,
                    date: listReminder[index].details.date ?? '',
                    time: listReminder[index].details.time ?? '',
                    state: state,
                  );
                }),
              ),

            ],
          )),
    );
  }
}
