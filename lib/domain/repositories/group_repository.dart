import 'package:ghichu/domain/entities/group_entity.dart';

abstract class GroupRepository {
  Future<List<GroupEntity>> getGroupListLocal();
  Future<int> setGroupLocal(GroupEntity groups);
  Future<void> setDefaultGroup();
  Future<void> deleteGroupLocal(int index);
  Future<void> addAllGroupLocal(List<GroupEntity> list);
  Future<void> updateGroupLocal(int index, GroupEntity groups);
}
