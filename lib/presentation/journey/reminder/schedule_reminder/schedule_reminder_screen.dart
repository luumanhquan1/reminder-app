import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/common/enums/reminder_enum.dart';
import 'package:ghichu/common/untils/reminder_until.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';

import 'package:ghichu/presentation/journey/reminder/schedule_reminder/widgets/sticky_header_widget.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/app_bar_reminder.dart';

class SchedulePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ManageReminderBloc, ManageReminderState>(
        builder: (context, state) {
      return Scaffold(
        appBar: AppBarReminderWidget(
          isIconEdit: true,
          actions: true
              ? () {
                  // reminderUntil(
                  //     scheduleReminderBloc: scheduleReminderBloc,
                  //     type: ReminderEnum.Schedule,
                  //     controller: snapshot.data.textEditing,
                  //     keyGroup: 'Reminder',
                  //     keyDate: snapshot.data.keyDate);
                  // scheduleReminderBloc
                  //     .scheduleReminderState.indexGroupReminder = null;
                  // scheduleReminderBloc.scheduleReminderState.indexGroup =
                  // null;
                  // scheduleReminderBloc.update();
                }
              : null,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                child: GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Schedule',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w900,
                        fontSize: ScreenUtil().setSp(30)),
                  ),
                ),
              ),
              Column(
                children: List.generate(state.listReminder.length, (index) {
                  String date=state.listReminder.keys.elementAt(index);
                  return StickyReminderSchedule(
                    header: date,
                    color: Colors.black.value.toString(),
                    listReminder: state.listReminder[date],
                  );
                }),
              )
            ],
          ),
        ),
      );
    });
  }
}
