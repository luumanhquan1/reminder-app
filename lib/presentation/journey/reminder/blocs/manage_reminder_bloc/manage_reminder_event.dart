import 'package:flutter/cupertino.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

abstract class ManageReminderEvent {}

class GetDataReminderAllEvent extends ManageReminderEvent {
  final List<GroupEntity> listGroup;

  GetDataReminderAllEvent({@required this.listGroup});
}
class GetDataScheduledEvent extends ManageReminderEvent {
  final List<GroupEntity> listGroup;
  GetDataScheduledEvent({@required this.listGroup});
}
class GetDateToDayEvent extends ManageReminderEvent {
  final List<GroupEntity> listGroup;
  GetDateToDayEvent({@required this.listGroup});
}
class GetDateGroupEvent extends ManageReminderEvent {
  final List<GroupEntity> listGroup;
  final GroupEntity groupEntity;
  GetDateGroupEvent({@required this.groupEntity, @required this.listGroup});
}

class EditReminderEvent extends ManageReminderEvent {
  final ReminderEntity reminderEntity;

  final String group;
  EditReminderEvent(
      {@required this.reminderEntity,

      @required this.group});
}
class AddControllerTextFieldEvent extends ManageReminderEvent{}
class AddReminderEvent extends ManageReminderEvent{
 final String title,group,date;
  AddReminderEvent({this.title, this.group, this.date});
}
class SearchReminderEvent extends ManageReminderEvent{
  final String search;

  SearchReminderEvent(this.search);

}
class DeleteReminderEvent extends ManageReminderEvent {
  final ReminderEntity reminderEntity;
  final int index;
  DeleteReminderEvent({@required this.reminderEntity, this.index});
}
class SelectReminderEvent extends ManageReminderEvent{
  final int indexReminder;
  final int indexGroup;

  SelectReminderEvent({this.indexReminder, this.indexGroup});
}
