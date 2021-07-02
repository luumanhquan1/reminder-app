import 'dart:developer';

import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/repositories/group_repository.dart';

class GroupUseCase {
  final GroupRepository groupRepository;

  GroupUseCase({this.groupRepository});

  Future<List<GroupEntity>> getUnitList() async {
    log('>>>Group UseCase');
    List<GroupEntity> groups = await groupRepository.getGroupListLocal();
    if (groups.isEmpty) {
      await groupRepository.setDefaultGroup();
      groups = await groupRepository.getGroupListLocal();
      return groups;
    }
    return groups;
  }

  Future<int> setGroup(GroupEntity groupEntity) async {
    return await groupRepository.setGroupLocal(groupEntity);
  }

  Future<void> orderGroupLocal(List<GroupEntity> list) async {
    await groupRepository.addAllGroupLocal(list);
  }
  Future<void> deleteGroupLocal(int index) async {
    await groupRepository.deleteGroupLocal(index);
  }
  Future<void> updateGroupLocal(GroupEntity groupEntity,String oldNameGroup,int index) async {
    await groupRepository.updateGroupLocal(groupEntity,oldNameGroup,index);

  }
}
