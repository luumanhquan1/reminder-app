import 'package:equatable/equatable.dart';

import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

// ignore: must_be_immutable
abstract class ManageReminderState extends Equatable {}
// ignore: must_be_immutable
class InitManagerReminderState extends ManageReminderState{
  Map<String, List<ReminderEntity>> listReminder;
  List<GroupEntity> listGroup;
  List<ReminderEntity> reminderGroupOrToday;
  bool isChangeState;
  InitManagerReminderState(
      {this.reminderGroupOrToday,
        this.isChangeState,
        this.listReminder,
        this.listGroup});
  InitManagerReminderState update(
      {Map<String, List<ReminderEntity>> listReminder,
        List<ReminderEntity> reminderGroupOrToday,
        bool isChangeState,
        List<GroupEntity> listGroup}) =>
      InitManagerReminderState(
          reminderGroupOrToday:
          reminderGroupOrToday ?? this.reminderGroupOrToday,
          isChangeState: isChangeState ?? this.isChangeState,
          listReminder: listReminder ?? this.listReminder,
          listGroup: listGroup ?? this.listGroup);
  @override
  // TODO: implement props
  List<Object> get props => [
    this.listReminder,
    this.isChangeState,
    this.listGroup,
    this.reminderGroupOrToday
  ];
}
