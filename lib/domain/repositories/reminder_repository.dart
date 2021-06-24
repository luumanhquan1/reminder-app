import 'package:ghichu/domain/entities/reminder_entity.dart';

abstract class ReminderRepository{
  Future<int> setReminder(ReminderEntity reminderEntity);
  Future<List<ReminderEntity>> getReminderLocal();
}