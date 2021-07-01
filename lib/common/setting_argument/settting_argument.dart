import 'package:flutter/material.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_state.dart';

class SettingNewReminder {
  final List<GroupEntity> listGroup;
  final bool isEditReminder;
  SettingNewReminder({this.listGroup, this.isEditReminder});
}

class SettingListGroup {
  final List<GroupEntity> listGroup;
  final GroupEntity group;
  SettingListGroup({this.listGroup, this.group});
}

class SettingEditGroup {
  final GroupEntity groupEntity;

  SettingEditGroup(this.groupEntity);
}

class SettingDetails {
  final InitDetailsState state;
  final String title, note, group;

  SettingDetails({
    this.group,
    this.state,
    this.title,
    this.note,
  });
}

class SettingPriority {
  final String priority;
  final int indexSelect;
  SettingPriority({this.priority, this.indexSelect});
}
