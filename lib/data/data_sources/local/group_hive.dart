import 'dart:developer';
import 'package:ghichu/common/configs/local_db_setup.dart';
import 'package:ghichu/domain/entities/group_entity.dart';

class GroupLocalDataSource {
  final LocalDbSetup localDbSetup;

  GroupLocalDataSource({this.localDbSetup});
  Future<List<GroupEntity>> getGroupLocalList() async {
    log('>>>GroupsHive');

    List<GroupEntity> listGroup = [];
    int length = localDbSetup.groupBox.length;
    for (int i = 0; i < length; i++) {
      GroupEntity groups = localDbSetup.groupBox.getAt(i);
      listGroup.add(groups);
    }

    return listGroup;
  }

  Future<int> setGroupLocal(GroupEntity groups) async {
    groups.id=localDbSetup.groupBox.length;
    return await localDbSetup.groupBox.add(groups);
  }

  Future<void> deleteGroupLocal(int index) async {
    await localDbSetup.groupBox.deleteAt(index);
  }

  Future<void> updateGroupLocal(GroupEntity groupEntity) async {
    await localDbSetup.groupBox.putAt(groupEntity.id, groupEntity);

  }

  Future<void> addAllGroupLocal(List<GroupEntity> list) async {
    await localDbSetup.groupBox.clear();
    await localDbSetup.groupBox.addAll(list);
  }
}
