import 'package:flutter/cupertino.dart';
import 'package:ghichu/data/models/model_map.dart';
import 'package:ghichu/data/models/reminder.dart';
import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';


class ScheduleReminderState {
  Map<String, List<Reminder>> reminderSchedule = {};
  String title;
  String keyDate;
  int indexReminder, indexGroup, indexGroupReminder;
  Map<String, TextFiledController> textEditing;

  ScheduleReminderState(
      {this.reminderSchedule,
      this.title,
      this.keyDate,
      this.indexReminder,
      this.indexGroupReminder,
      this.textEditing,
      this.indexGroup});

  void addTextEditing() {
    for (int i = 0; i < reminderSchedule.length; i++) {
      textEditing.addAll({
        '$i': TextFiledController(
            textEditingController: TextEditingController(),
            focusNode: FocusNode())
      });
    }
  }

  void setGroup(int index) {
    this.indexGroup = index;
  }

  void setIndexReminder(int index, int group) {
    indexReminder = index;
    indexGroupReminder = group;
  }

  void setTitle(String title) {
    this.title = title;
  }

  void addReminder(
      {@required String title,
      @required String group,
      @required String keyDate}) {
    if (title.trim().isNotEmpty) {
      if (ModelListReminder.listReminder['$group']['$keyDate'] == null) {
        ModelListReminder.listReminder['$group'].addAll({
          keyDate: [
            Reminder(
                title,
                '',
                group,
                'none',
                DateTime.parse(this.keyDate).millisecondsSinceEpoch,
                DateTime.now().millisecondsSinceEpoch,
                DateTime.now().millisecondsSinceEpoch,
                false)
          ].toList()
        });
      } else {
        ModelListReminder.listReminder['$group']['$keyDate'].add(Reminder(
            title,
            '',
            group,
            'none',
            DateTime.parse(keyDate).millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch,
            DateTime.now().millisecondsSinceEpoch,
            false));
      }
    }
  }

  int getReminder() {
    reminderSchedule.clear();
    ModelListReminder.listReminder.values.forEach((element) {
      element.forEach((key, value) {
        if (key != 'orther') {
          if (reminderSchedule.containsKey(key)) {
          } else {
            reminderSchedule.addAll({key: value});
          }
        }
      });
    });
    return reminderSchedule.keys.length;
  }
}
