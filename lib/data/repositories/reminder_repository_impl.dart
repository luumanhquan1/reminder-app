import 'package:ghichu/data/data_sources/local/reminder_hive.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/domain/repositories/reminder_repository.dart';

class ReminderRepositoryImpl extends ReminderRepository {
  final ReminderLocalDataSource reminderLDs;

  ReminderRepositoryImpl({this.reminderLDs});

  @override
  Future<int> setReminder(ReminderEntity reminderEntity) async {
    return await reminderLDs.setReminder(reminderEntity);
  }

  Future<Map<String, int>> getLeghtReminderToGroupLocal(
      List<GroupEntity> listGroup) async {
    return await reminderLDs.getLeghtReminderToGroupLocal(listGroup);
  }
  Future<int> getLengthScheduledLocal() async {
    return await reminderLDs.getLengthScheduledLocal();
  }

  @override
  Future<void> deleteReminderToGroupLocal(String group) async {
    await reminderLDs.deleteReminderToGroupLocal(group);
  }

  @override
  Future<int> getLenghtAllReminderLocal() async {
    return await reminderLDs.getLenghtAllReminderLocal();
  }

  @override
  Future<int> getLenghtToDayReminderLocal(String date) async {
    return await reminderLDs.getLenghtToDayReminderLocal(date);
  }

  @override
  Future<Map<String, List<ReminderEntity>>> getReminderAllToGroupLoCal() {
    return reminderLDs.getReminderAllToGroup();
  }

  @override
  Future<Map<String, List<ReminderEntity>>> getReminderScheduledLoCal() {
   return reminderLDs.getReminderSchedule();
  }


}
