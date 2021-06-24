import 'package:hive/hive.dart';

part 'details_entity.g.dart';
@HiveType(typeId: 2)
class DetailsEntity {
  @HiveField(0)
  String date;
  @HiveField(1)
  String time;
  @HiveField(2)
  String priority;

  DetailsEntity({this.date, this.time, this.priority});
}
