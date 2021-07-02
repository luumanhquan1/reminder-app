import 'dart:developer';

import 'package:ghichu/common/configs/local_db_setup.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

class ReminderLocalDataSource {
  final LocalDbSetup localDbSetup;

  ReminderLocalDataSource({this.localDbSetup});
  Future<int> setReminder(ReminderEntity reminderEntity) async {
    // reminderEntity.id = localDbSetup.reminderBox.length;
    return await localDbSetup.reminderBox.add(reminderEntity);
  }

  Future<List<ReminderEntity>> getReminderLocal() async {
    List<ReminderEntity> listReminder = [];
    for (int i = 0; i < localDbSetup.reminderBox.length; i++) {
      ReminderEntity reminderEntity = localDbSetup.reminderBox.getAt(i);
      listReminder.add(reminderEntity);
    }
    return listReminder;
  }

  Future<void> deleteReminderToGroupLocal(String group) async {
    for (int i = 0; i < localDbSetup.reminderBox.length; i++) {
      ReminderEntity reminderEntity = localDbSetup.reminderBox.getAt(i);
      if (reminderEntity.list == group) {
        localDbSetup.reminderBox.deleteAt(i);
      }
    }
  }
// Map<String,int> getLeghtReminderToGroupLocal(List<GroupEntr>)
}
