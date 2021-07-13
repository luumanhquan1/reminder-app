import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

abstract class ReminderRepository {
  Future<int> setReminder(ReminderEntity reminderEntity);

  Future<void> deleteReminderToGroupLocal(String group);
  Future<Map<String, int>> getLeghtReminderToGroupLocal(
      List<GroupEntity> listGroup);
  Future<int> getLengthScheduledLocal();
  Future<int> getLenghtAllReminderLocal();
  Future<int> getLenghtToDayReminderLocal(String date);
  Future<Map<String, List<ReminderEntity>>> getReminderAllToGroupLoCal();
  Future<Map<String, List<ReminderEntity>>> getReminderScheduledLoCal();
  Future<List<ReminderEntity>> getReminderToDayLocal();
  Future<List<ReminderEntity>> getReminderToGroupLocal({String group});
  Future<void> editReminderLocal(
      ReminderEntity oldReminder, ReminderEntity newReminder);
  Future<void> deleteReminderLocal(ReminderEntity oldReminder);
  Future<Map<String, List<ReminderEntity>>> getReminderSearch(String search);
}
