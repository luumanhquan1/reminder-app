import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghichu/common/enums/reminder_enum.dart';
import 'package:ghichu/common/untils/reminder_until.dart';
import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
import 'package:ghichu/presentation/journey/reminder/all_reminder/bloc/all_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/schedule_reminder/bloc/schedule_reminder_bloc.dart';

import '../reminder_constants.dart';

class AddWidget extends StatelessWidget {
  String keyGroup, keyDate;
  Map<String, TextFiledController> controller;
  int index;

  ScheduleReminderBloc scheduleReminderBloc;
  AddWidget(
      {Key key,
      this.keyGroup,
      this.controller,
      this.keyDate,
      this.index,
      this.scheduleReminderBloc})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextField(
      // controller: controller['$index'].textEditingController,
      // focusNode: controller['$index'].focusNode,
      onTap: () {
        // if (allReminderBloc == null) {
        //   scheduleReminderBloc.scheduleReminderState.indexGroupReminder = null;
        //   if (index != scheduleReminderBloc.scheduleReminderState.indexGroup) {
        //     reminderUntil(
        //         type: ReminderEnum.Schedule,
        //         controller: controller,
        //         scheduleReminderBloc: scheduleReminderBloc,
        //         keyGroup: 'Reminder',
        //         keyDate: scheduleReminderBloc.scheduleReminderState.keyDate);
        //   }
        //   controller['$index'].focusNode.requestFocus();
        //   scheduleReminderBloc.setKeyDate(keyDate);
        //   scheduleReminderBloc.setIndexGroup(index);
        // } else {
        //   allReminderBloc.allReminderState.indexGroupReminder = null;
        //   if (index != allReminderBloc.allReminderState.indexGroup) {
        //     reminderUntil(
        //         type: ReminderEnum.All,
        //         controller: controller,
        //         keyGroup: allReminderBloc.allReminderState.group,
        //         allReminderBloc: allReminderBloc);
        //   }
        //   controller['$index'].focusNode.requestFocus();
        //   allReminderBloc.setIndexGroup(index);
        //   allReminderBloc.setGroup(keyGroup);
        // }
      },
      style: TextStyle(fontSize: ScreenUtil().setSp(16)),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 1.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 1.5),
        ),
        // suffixIcon: StreamBuilder(
        //     initialData: scheduleReminderBloc == null
        //         ? allReminderBloc.allReminderState
        //         : scheduleReminderBloc.scheduleReminderState,
        //     stream: scheduleReminderBloc == null
        //         ? allReminderBloc.allController
        //         : scheduleReminderBloc.streamController,
        //     builder: (context, snapshot) {
        //       return Visibility(
        //           visible: index == snapshot.data.indexGroup ? true : false,
        //           child: GestureDetector(
        //             onTap: () {},
        //             child: Icon(
        //               Icons.error_outline,
        //               size: ScreenUtil().setSp(23),
        //               color: ReminderContants.colorIcon,
        //             ),
        //           ));
        //     }),
        prefixIcon: Icon(
          Icons.add_circle_outlined,
          size: ScreenUtil().setSp(25),
          color: Colors.black45,
        ),
        // helperText: scheduleReminderBloc != null ? "Reminder" : '',
        helperStyle:
            TextStyle(color: Colors.black45, fontSize: ScreenUtil().setSp(13)),
      ),
    );
  }
}
