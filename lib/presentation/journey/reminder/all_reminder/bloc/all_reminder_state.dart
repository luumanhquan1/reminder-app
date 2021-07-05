import 'package:equatable/equatable.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

abstract class AllReminderState extends Equatable {}

// ignore: must_be_immutable
class InitAllReminderState extends AllReminderState {
  Map<String, List<ReminderEntity>> listReminder;
  List<GroupEntity> listGroup;
  InitAllReminderState({this.listReminder, this.listGroup});
  InitAllReminderState update(
          {Map<String, List<ReminderEntity>> listReminder,
          List<GroupEntity> listGroup}) =>
      InitAllReminderState(
          listReminder: listReminder ?? this.listReminder,
          listGroup: listGroup ?? this.listGroup);
  @override
  // TODO: implement props
  List<Object> get props => [this.listReminder];
}
