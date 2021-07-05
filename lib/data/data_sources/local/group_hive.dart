import 'dart:developer';

import 'package:ghichu/common/configs/local_db_setup.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

class GroupLocalDataSource {
  final LocalDbSetup localDbSetup;

  GroupLocalDataSource({this.localDbSetup});
  Future<List<GroupEntity>> getGroupLocalList() async {
    List<GroupEntity> listGroup = [];
    int length = localDbSetup.groupBox.length;
    for (int i = 0; i < length; i++) {
      GroupEntity groups = localDbSetup.groupBox.getAt(i);
      listGroup.add(groups);
    }

    return listGroup;
  }

  Future<int> setGroupLocal(GroupEntity groups) async {
    return await localDbSetup.groupBox.add(groups);
  }

  Future<void> deleteGroupLocal(int index) async {
    await localDbSetup.groupBox.deleteAt(index);
  }

  Future<void> updateGroupLocal(
      GroupEntity groupEntity, String oldNameGroup,int index) async {
    await localDbSetup.groupBox.putAt(index, groupEntity);
    if (localDbSetup.reminderBox.values
            .where((element) => element.list == oldNameGroup)
            .length !=
        0) {
      int index=0;
      localDbSetup.reminderBox.values.forEach((element) {
        if (element.list == oldNameGroup) {
          localDbSetup.reminderBox.putAt(
              index,
              ReminderEntity(
                  id: element.id,
                  title: element.title,
                  note: element.note,
                  details: element.details,
                  list: groupEntity.name,
                  createAt: element.createAt,
                  lastUpdate: element.lastUpdate));
        }
        index++;
      });
    }
  }

  Future<void> addAllGroupLocal(List<GroupEntity> list) async {
    await localDbSetup.groupBox.clear();
    await localDbSetup.groupBox.addAll(list);
  }
}
