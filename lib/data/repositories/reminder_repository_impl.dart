import 'package:ghichu/data/data_sources/local/reminder_hive.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/domain/repositories/reminder_repository.dart';

class ReminderRepositoryImpl extends ReminderRepository {
  final ReminderLocalDataSource reminderLDs;

  ReminderRepositoryImpl({this.reminderLDs});

  @override
  Future<int> setReminder(ReminderEntity reminderEntity) async {
    return await reminderLDs.setReminder(reminderEntity);
  }

  @override
  Future<List<ReminderEntity>> getReminderLocal() async {
      return await reminderLDs.getReminderLocal();
  }
}
