import 'package:ghichu/data/models/reminder.dart';
import 'package:hive/hive.dart';

import 'details_entity.dart';
part 'reminder_entity.g.dart';
@HiveType(typeId: 1)
class ReminderEntity{
  @HiveField(0)
  String title;
  @HiveField(1)
  String note;
  @HiveField(2)
  DetailsEntity details;
  @HiveField(3)
  String list;
  @HiveField(4)
  String createAt;
  @HiveField(5)
  String lastUpdate;

  ReminderEntity({this.title, this.note, this.details, this.list, this.createAt,
    this.lastUpdate});
}