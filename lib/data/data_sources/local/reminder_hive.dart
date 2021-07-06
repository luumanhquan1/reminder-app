import 'dart:developer';

import 'package:ghichu/common/configs/local_db_setup.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

class ReminderLocalDataSource {
  final LocalDbSetup localDbSetup;

  ReminderLocalDataSource({this.localDbSetup});
  Future<int> setReminder(ReminderEntity reminderEntity) async {
    reminderEntity.id = localDbSetup.reminderBox.length;
    return await localDbSetup.reminderBox.add(reminderEntity);
  }

  Future<Map<String, List<ReminderEntity>>> getReminderAllToGroup() async {
    List<ReminderEntity> listReminder = localDbSetup.reminderBox.values.toList();
    Map<String, List<ReminderEntity>> reminderToGroup = {};
    listReminder.forEach((element) {
      if (reminderToGroup.containsKey(element.list)) {
        reminderToGroup[element.list].add(element);
      } else {
        reminderToGroup.addAll({
          element.list: [element].toList()
        });
      }
    });
    return reminderToGroup;
  }

  Future<void> deleteReminderToGroupLocal(String group) async {
    final result = localDbSetup.reminderBox.values
        .where((element) => element.list != group).toList();
    await localDbSetup.reminderBox.clear();
    await localDbSetup.reminderBox.addAll(result);
  }

  Future<int> getLenghtAllReminderLocal() async {
    return localDbSetup.reminderBox.length;
  }

  Future<Map<String, int>> getLeghtReminderToGroupLocal(
      List<GroupEntity> listGroup) async {
    final result = localDbSetup.reminderBox.values;
    Map<String, int> getLeghtReminder = {};
    listGroup.forEach((element) {
      getLeghtReminder.addAll({
        element.name:
            result.where((reminder) => element.name == reminder.list).length
      });
    });
    return getLeghtReminder;
  }

  Future<int> getLengthScheduledLocal() async {
    final result = localDbSetup.reminderBox.values;
    return result.where((element) => element.details.date != null).length;
  }

  Future<int> getLenghtToDayReminderLocal(String date) async {
    final result = localDbSetup.reminderBox.values;
    return result.where((element) => element.details.date == date).length;
  }
}
