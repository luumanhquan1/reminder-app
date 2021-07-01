import 'package:hive/hive.dart';
part 'group_entity.g.dart';

@HiveType(typeId: 0)
class GroupEntity {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String color;
  @HiveField(3)
  String createAt;
  @HiveField(4)
  String lastUpdate;

  GroupEntity({this.id,this.name, this.color, this.createAt, this.lastUpdate});
}
