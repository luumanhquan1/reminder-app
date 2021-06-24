import 'package:hive/hive.dart';
part 'group_entity.g.dart';

@HiveType(typeId: 0)
class GroupEntity {
  @HiveField(0)
  String name;
  @HiveField(1)
  String color;
  @HiveField(2)
  String createAt;
  @HiveField(3)
  String lastUpdate;

  GroupEntity({this.name, this.color, this.createAt, this.lastUpdate});
}
