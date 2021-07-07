import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';
import 'package:ghichu/presentation/journey/reminder/reminder_constants.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/app_bar_reminder.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/list_reminder.dart';

// ignore: must_be_immutable
class TodayPage extends StatefulWidget {
  final GroupEntity groupEntity;

  TodayPage({this.groupEntity});

  @override
  _State createState() => _State();
}

class _State extends State<TodayPage> {
  SlidableController slidableController;
  @override
  void initState() {
    slidableController = SlidableController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageReminderBloc, ManageReminderState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is InitManagerReminderState){
          return Scaffold(
            appBar: AppBarReminderWidget(
              isIconEdit: false,
              actions: true
                  ? () {
                // todayReminderBloc.todayReminderState.indexReminder = null;
                // todayReminderBloc.update();
              }
                  : null,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    child: Text(
                      widget.groupEntity == null
                          ? 'Hôm nay'
                          : widget.groupEntity.name,
                      style: TextStyle(
                          color: widget.groupEntity == null
                              ? Colors.blue
                              : Color(int.parse(widget.groupEntity.color)),
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(30)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  state.reminderGroupOrToday.length == 0
                      ? Center(
                    heightFactor: ScreenUtil().setHeight(30),
                    child: Text(
                      ReminderContants.emptyTxt,
                      style: ReminderContants.textStyleEmpty,
                    ),
                  )
                      : Column(
                    children: List.generate(
                        state.reminderGroupOrToday.length, (index) {
                      ReminderEntity reminder =
                      state.reminderGroupOrToday[index];
                      if (widget.groupEntity == null) {
                        return ListReminder(
                          slidableController: slidableController,
                          title: reminder.title,
                          note: reminder.note,
                          group: reminder.list,
                          time: reminder.details.time ?? '',
                        );
                      }
                      return ListReminder(
                        slidableController: slidableController,
                        title: reminder.title,
                        note: reminder.note,
                        date: reminder.details.date ?? '',
                        time: reminder.details.time ?? '',
                      );
                    }),
                  )
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
}
