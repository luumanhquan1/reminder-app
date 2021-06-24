import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/common/enums/reminder_enum.dart';
import 'package:ghichu/common/untils/reminder_until.dart';
import 'package:ghichu/presentation/journey/reminder/schedule_reminder/bloc/schedule_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/schedule_reminder/bloc/schedule_reminder_state.dart';
import 'package:ghichu/presentation/journey/reminder/schedule_reminder/widgets/sticky_header_widget.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/app_bar_reminder.dart';

class SchedulePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SchedulePage> {
  ScheduleReminderBloc scheduleReminderBloc = new ScheduleReminderBloc();
  String key;
  bool isEdit;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ScheduleReminderState>(
        initialData: scheduleReminderBloc.scheduleReminderState,
        stream: scheduleReminderBloc.streamController,
        builder: (context, snapshot) {
          if (snapshot.data.indexGroupReminder != null) {
            isEdit = true;
          } else if (snapshot.data.indexGroup == null) {
            isEdit = false;
          } else {
            isEdit = true;
          }
          return Scaffold(
            appBar: AppBarReminderWidget(
              isIconEdit: isEdit,
              actions: isEdit
                  ? () {
                      reminderUntil(
                          scheduleReminderBloc: scheduleReminderBloc,
                          type: ReminderEnum.Schedule,
                          controller: snapshot.data.textEditing,
                          keyGroup: 'Reminder',
                          keyDate: snapshot.data.keyDate);
                      scheduleReminderBloc
                          .scheduleReminderState.indexGroupReminder = null;
                      scheduleReminderBloc.scheduleReminderState.indexGroup =
                          null;
                      scheduleReminderBloc.update();
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
                    children: List.generate(
                        snapshot.data.reminderSchedule.length, (index) {
                      int indexReminder = 0;
                      return StickyReminderSchedule(
                        keyDate: snapshot.data.keyDate,
                        scheduleReminderBloc: scheduleReminderBloc,
                        indexReminder: indexReminder,
                        title: snapshot.data.reminderSchedule.keys
                            .elementAt(index),
                        indexSticky: index,
                        controler: snapshot.data.textEditing,
                      );
                    }),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scheduleReminderBloc.scheduleReminderState.getReminder();
      scheduleReminderBloc.addTextEditing();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    //
    scheduleReminderBloc.dispose();
    super.dispose();
  }
}
