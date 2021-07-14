import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';

// ignore: must_be_immutable
abstract class ManageReminderState extends Equatable {}

// ignore: must_be_immutable
class InitManagerReminderState extends ManageReminderState {
  Map<String, List<ReminderEntity>> listReminder;
  Map<String, TextFiledController> listController;
  List<GroupEntity> listGroup;
  List<ReminderEntity> reminderGroupOrToday;
  bool isChangeState, isUpDate;
  int indexGroup, indexReminder;
  InitManagerReminderState(
      {this.reminderGroupOrToday,
      this.listController,
      this.isChangeState,
      this.listReminder,
      this.listGroup,
      this.isUpDate,
      this.indexGroup,
      this.indexReminder});
  InitManagerReminderState update(
          {Map<String, List<ReminderEntity>> listReminder,
          List<ReminderEntity> reminderGroupOrToday,
          Map<String, TextFiledController> listController,
          bool isChangeState,
          bool isUpDate,
          List<GroupEntity> listGroup,
          int indexGroup,
          indexReminder}) =>
      InitManagerReminderState(
          listController: listController ?? this.listController,
          indexGroup: indexGroup ?? this.indexGroup,
          indexReminder: indexReminder ?? this.indexReminder,
          isUpDate: isUpDate ?? this.isUpDate,
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
        this.reminderGroupOrToday,
        this.indexReminder,
        this.indexGroup,
        this.listController
      ];
}

class EditReminderState extends ManageReminderState {
  final ReminderEntity reminderEntity;
  final List<GroupEntity> listGroup;
  final GroupEntity groupEntity;
  EditReminderState(
      {@required this.reminderEntity,
      @required this.listGroup,
      @required this.groupEntity});
  @override
  List<Object> get props =>
      [this.reminderEntity, this.listGroup, this.groupEntity];
}
