import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/data/models/model_map.dart';
import 'package:ghichu/data/models/reminder.dart';
import 'package:ghichu/presentation/journey/reminder/today_reminder/bloc/today_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/today_reminder/bloc/today_reminder_state.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/app_bar_reminder.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/list_reminder.dart';


class TodayPage extends StatefulWidget {
  String keyGroup;

  TodayPage({this.keyGroup});

  @override
  _State createState() => _State();
}

class _State extends State<TodayPage> {
  bool isEdit;
  int indexReminder=0;
  TodayReminderBloc todayReminderBloc = TodayReminderBloc();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TodayReminderState>(
        initialData: todayReminderBloc.todayReminderState,
        stream: todayReminderBloc.todayReminderController,
        builder: (context, snapshot) {
          indexReminder=0;
          if (snapshot.data.indexReminder == null) {
            isEdit = false;
          } else {
            isEdit = true;
          }
          return Scaffold(
            appBar: AppBarReminderWidget(
              isIconEdit: isEdit,
              actions: isEdit
                  ? () {
                      todayReminderBloc.todayReminderState.indexReminder = null;
                      todayReminderBloc.update();
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
                      widget.keyGroup == null
                          ? 'Hôm nay'
                          : ModelListReminder.myList[widget.keyGroup].title,
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(30)),
                    ),
                  ),
                  Column(
                      children: List.generate(
                          widget.keyGroup == null
                              ? ModelListReminder.listReminder.values.length
                              : ModelListReminder.listReminder[widget.keyGroup]
                                  .values.length, (index) {
                    return Column(
                      children: List.generate(
                          widget.keyGroup == null
                              ? ModelListReminder.listReminder.values.elementAt(
                                          index)['${snapshot.data.nowDate}'] ==
                                      null
                                  ? 0
                                  : ModelListReminder.listReminder.values
                                      .elementAt(
                                          index)['${snapshot.data.nowDate}']
                                      .length
                              : ModelListReminder
                                  .listReminder[widget.keyGroup].values
                                  .elementAt(index)
                                  .length, (index1) {
                        List<Reminder> reminder;
                        if (widget.keyGroup == null) {
                          reminder = ModelListReminder.listReminder.values
                              .elementAt(index)['${snapshot.data.nowDate}'];
                        } else {
                          reminder = ModelListReminder
                              .listReminder[widget.keyGroup].values
                              .elementAt(index);
                        }
                        indexReminder=indexReminder+1;
                        return ListReminder(
                          indexGroup: 0,
                          todayReminderBloc: todayReminderBloc,
                          indexReminder: indexReminder,
                          title: reminder[index1].title,
                          note: reminder[index1].note,
                          group: widget.keyGroup == null
                              ? ModelListReminder.myList[reminder[index1].group].title
                              : null,
                          time: reminder[index1].time,
                          date: reminder[index1].date,
                        );
                      }),
                    );
                  }))
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
      todayReminderBloc.getToday();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    todayReminderBloc.dispose();
    super.dispose();
  }
}
