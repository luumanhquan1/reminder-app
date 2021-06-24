

import 'package:ghichu/data/models/model_map.dart';
import 'package:ghichu/data/models/reminder.dart';

class AllReminderState {
  String group;
  String title;
  int indexGroup, indexReminder,indexGroupReminder;
  String hedear;

  void setGroup(String group) {
    this.group = group;
  }

  void setIndexReminder(int index,int indexGroup) {
    this.indexReminder = index;
    this.indexGroupReminder=indexGroup;
  }

  void addAll(String group, String title) {

    if (ModelListReminder.listReminder['${group}']['orther'] == null) {
      ModelListReminder.listReminder['${group}'].addAll({
        'orther': [
          Reminder(
              title,
              '',
              group,
              'none',
              null,
              DateTime.now().millisecondsSinceEpoch,
              DateTime.now().millisecondsSinceEpoch,
              false)
        ].toList()
      });
    } else {
      ModelListReminder.listReminder['$group']['orther'].add(Reminder(
          title,
          '',
          group,
          'none',
          null,
          DateTime.now().millisecondsSinceEpoch,
          DateTime.now().millisecondsSinceEpoch,
          false));
    }
  }
}
