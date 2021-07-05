import 'package:flutter/cupertino.dart';
import 'package:ghichu/common/enums/reminder_enum.dart';
import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
import 'package:ghichu/presentation/journey/reminder/all_reminder/bloc/all_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/schedule_reminder/bloc/schedule_reminder_bloc.dart';

void reminderUntil(
    {ReminderEnum type,
    ScheduleReminderBloc scheduleReminderBloc,

    String keyGroup,
    Map<String, TextFiledController> controller,
    String keyDate}) {
  switch (type) {
    case ReminderEnum.All:
      for (int i = 0; i < controller.length; i++) {
        if (controller['$i'].textEditingController.text.isNotEmpty) {
          // allReminderBloc.addAll(
          //     keyGroup, controller['$i'].textEditingController.text);
        }
        controller['$i'].textEditingController.text = '';
        controller['$i'].focusNode.unfocus();
      }
      break;
    case ReminderEnum.Schedule:
      for (int i = 0; i < controller.length; i++) {
        if (controller['$i'].textEditingController.text.isNotEmpty) {
          scheduleReminderBloc.addReminder(
              title: controller['$i'].textEditingController.text,
              group: keyGroup,
              keyDate: keyDate);
        }
        controller['$i'].textEditingController.text = '';
        controller['$i'].focusNode.unfocus();
      }
      break;
    case ReminderEnum.Today:
      break;
  }
}
