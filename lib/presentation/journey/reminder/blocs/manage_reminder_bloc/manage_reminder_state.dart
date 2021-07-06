import 'package:equatable/equatable.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

// ignore: must_be_immutable
class ManageReminderState extends Equatable{
  Map<String, List<ReminderEntity>> listReminder;
  List<GroupEntity> listGroup;
  bool isChangeState;
  ManageReminderState({this.isChangeState, this.listReminder, this.listGroup});
  ManageReminderState update(
      {Map<String, List<ReminderEntity>> listReminder,
        bool isChangeState,
        List<GroupEntity> listGroup}) =>
      ManageReminderState(
          isChangeState: isChangeState ?? this.isChangeState,
          listReminder: listReminder ?? this.listReminder,
          listGroup: listGroup ?? this.listGroup);
  @override
  // TODO: implement props
  List<Object> get props =>
      [this.listReminder, this.isChangeState, this.listGroup];

}