import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

// ignore: must_be_immutable
abstract class ManageReminderState extends Equatable {}

// ignore: must_be_immutable
class InitManagerReminderState extends ManageReminderState {
  Map<String, List<ReminderEntity>> listReminder;
  List<GroupEntity> listGroup;
  List<ReminderEntity> reminderGroupOrToday;
  bool isChangeState,isUpDate;
  InitManagerReminderState(
      {this.reminderGroupOrToday,
      this.isChangeState,
      this.listReminder,
      this.listGroup,this.isUpDate});
  InitManagerReminderState update(
          {Map<String, List<ReminderEntity>> listReminder,
          List<ReminderEntity> reminderGroupOrToday,
          bool isChangeState,
            bool isUpDate,
          List<GroupEntity> listGroup}) =>
      InitManagerReminderState(
        isUpDate: isUpDate??this.isUpDate,
          reminderGroupOrToday:
              reminderGroupOrToday ?? this.reminderGroupOrToday,
          isChangeState: isChangeState ?? this.isChangeState,
          listReminder: listReminder ?? this.listReminder,
          listGroup: listGroup ?? this.listGroup);
  @override
  List<Object> get props => [
    this.isUpDate,
        this.listReminder,
        this.isChangeState,
        this.listGroup,
        this.reminderGroupOrToday
      ];
}

class EditReminderState extends ManageReminderState {
  final ReminderEntity reminderEntity;
  final List<GroupEntity> listGroup;
  final GroupEntity groupEntity;
  EditReminderState({@required this.reminderEntity,@required this.listGroup,@required this.groupEntity});
  @override
  List<Object> get props => [this.reminderEntity,this.listGroup,this.groupEntity];
}
