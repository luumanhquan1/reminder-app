import 'dart:developer';
import 'package:ghichu/common/extension/extension_datetime.dart';
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
    List<ReminderEntity> listReminder =
        await reminderRepository.getReminderLocal();
    String toDay = DateTime.now().dateTimeFormat();
    Map<String, List<ReminderEntity>> reminderScheduled = {};
    reminderScheduled.addAll({toDay: <ReminderEntity>[].toList()});
    listReminder.forEach((element) {
      if (reminderScheduled.containsKey(element.details.date)) {
        reminderScheduled[element.details.date].add(element);
      } else {
        reminderScheduled.addAll({
          element.details.date: [element].toList()
        });
      }
    });
    return reminderScheduled;
  }

  Future<Map<String, List<ReminderEntity>>> getReminderToGroup(
      List<GroupEntity> listGroup) async {
    Map<String, List<ReminderEntity>> reminderGroup = {};
    List<ReminderEntity> listReminder =
        await reminderRepository.getReminderLocal();
    listReminder.forEach((element) {
      if (reminderGroup.containsKey(element.list)) {
        reminderGroup[element.list].add(element);
      } else {
        //nếu chưa tồn tại key group thì tạo mới key
        reminderGroup.addAll({
          element.list: <ReminderEntity>[element].toList()
        });
      }
    });
    listGroup.forEach((element) {
      //nếu reminderGroup chưa tồn tại thì tạo list rỗng
      if (reminderGroup.containsKey(element.name) == false) {
        reminderGroup.addAll({element.name: []});
      }
    });
    return reminderGroup;
  }
  Future<void> deleteReminderToGroup(String group) async {
    log('message');
    await reminderRepository.deleteReminderToGroupLocal(group);
  }
}
