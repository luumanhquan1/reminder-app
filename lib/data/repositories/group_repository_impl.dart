import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ghichu/data/data_sources/local/group_hive.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/repositories/group_repository.dart';

class GroupRepositoryImpl extends GroupRepository {
  final GroupLocalDataSource groupLds;

  GroupRepositoryImpl({this.groupLds});
  @override
  Future<List<GroupEntity>> getGroupListLocal() {
    log('>>>GroupsRepository');
    return groupLds.getGroupLocalList();
  }

  @override
  Future<int> setGroupLocal(GroupEntity groups) async {
    return await groupLds.setGroupLocal(groups);
  }

  @override
  Future<void> setDefaultGroup() async {
    GroupEntity groups = GroupEntity(
        name: "Reminder",
        color: Colors.blue.value.toString(),
        createAt: DateTime.now().toString(),
        lastUpdate: DateTime.now().toString());
    await setGroupLocal(groups);
  }

  @override
  Future<void> deleteGroupLocal(int index) async {
    await groupLds.deleteGroupLocal(index);
  }

  @override
  Future<void> addAllGroupLocal(List<GroupEntity> list) async {
            await groupLds.addAllGroupLocal(list);
  }

  @override
  Future<void> updateGroupLocal( GroupEntity groupEntity,String oldNameGroup,int index) async {
         await groupLds.updateGroupLocal( groupEntity,oldNameGroup,index);
  }

}
