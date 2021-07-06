
import 'dart:developer';

import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/domain/repositories/reminder_repository.dart';

class ReminderUseCase {
  final ReminderRepository reminderRepository;

  ReminderUseCase({this.reminderRepository});
  Future<int> addReminder(ReminderEntity reminderEntity) async {
    return await reminderRepository.setReminder(reminderEntity);
  }

  Future<Map<String, List<ReminderEntity>>> getReminderScheduled() async {
    log('${reminderRepository.getReminderScheduledLoCal()}');
    return reminderRepository.getReminderScheduledLoCal();
  }
  Future<Map<String, List<ReminderEntity>>> getReminderAll(
      List<GroupEntity> listGroup) async {
    Map<String, List<ReminderEntity>> listReminder =
        await reminderRepository.getReminderAllToGroupLoCal();
    listGroup.forEach((element) {
      if (listReminder.containsKey(element.name) == false) {
        //nếu chưa tồn tại set List rỗng
        listReminder.addAll({element.name: []});
      }
    });

    return listReminder;
  }

  Future<List<ReminderEntity>> getReminderToDay() async {}
  Future<void> deleteReminderToGroup(String group) async {
    await reminderRepository.deleteReminderToGroupLocal(group);
  }

  Future<Map<String, int>> getLeghtReminderToGroupLocal(
      List<GroupEntity> listGroup) async {
    return reminderRepository.getLeghtReminderToGroupLocal(listGroup);
  }

  Future<int> getLengthScheduledLocal() async {
    return await reminderRepository.getLengthScheduledLocal();
  }

  Future<int> getLenghtAllReminderLocal() async {
    return await reminderRepository.getLenghtAllReminderLocal();
  }

  Future<int> getLenghtToDayReminderLocal(String date) async {
    return await reminderRepository.getLenghtToDayReminderLocal(date);
  }
  Future<Map<String, List<ReminderEntity>>> getReminderSchedule() async{
    return reminderRepository.getReminderScheduledLoCal();
  }
}
