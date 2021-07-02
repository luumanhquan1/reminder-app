import 'package:ghichu/data/models/reminder.dart';
import 'package:hive/hive.dart';

import 'details_entity.dart';
part 'reminder_entity.g.dart';

@HiveType(typeId: 1)
class ReminderEntity {
  @HiveField(0)
  int id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String note;
  @HiveField(3)
  DetailsEntity details;
  @HiveField(4)
  String list;
  @HiveField(5)
  String createAt;
  @HiveField(6)
  String lastUpdate;

  ReminderEntity(
      {this.id,
      this.title,
      this.note,
      this.details,
      this.list,
      this.createAt,
      this.lastUpdate});
}
