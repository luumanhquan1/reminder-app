import 'package:flutter/cupertino.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

abstract class ManageReminderEvent {}

class GetDataReminderAllEvent extends ManageReminderEvent {
  final List<GroupEntity> listGroup;

  GetDataReminderAllEvent({@required this.listGroup});
}

class GetDataScheduledEvent extends ManageReminderEvent {}

class GetDateToDayEvent extends ManageReminderEvent {}

class GetDateGroupEvent extends ManageReminderEvent {
  final GroupEntity groupEntity;
  GetDateGroupEvent({@required this.groupEntity});
}

class EditReminderEvent extends ManageReminderEvent {
  final ReminderEntity reminderEntity;
 final List<GroupEntity> listGroup;
 final GroupEntity groupEntity;
  EditReminderEvent({@required this.reminderEntity,@required this.listGroup,@required this.groupEntity});
}
