import 'package:flutter/material.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_state.dart';

abstract class NewReminderEvent {}

class UpDateNewReminderDetailsEvent extends NewReminderEvent {
  final bool isDateDetails;
  final InitDetailsState initDetailsState;
  UpDateNewReminderDetailsEvent({this.initDetailsState, this.isDateDetails});
}

class UpDateNewReminderListGroupEvent extends NewReminderEvent {
  final GroupEntity groups;
  UpDateNewReminderListGroupEvent({this.groups});
}

class ActiveBtn extends NewReminderEvent {
  final bool activeBtn;

  ActiveBtn({this.activeBtn});
}

class PushDetailEvent extends NewReminderEvent {}

class PushListGroupEvent extends NewReminderEvent {}

class AddReminderEvent extends NewReminderEvent {
  final String title, note, priority;
  final int date;
  final String group;

  AddReminderEvent(
      {this.title, this.note, this.date, this.group, this.priority});
}

class EditReminderEvent extends NewReminderEvent {
  final ReminderEntity oldReminder;
  final String title, note, priority;
  final DateTime date;
  final TimeOfDay time;
  final String group;
  final bool isDate, isTime;
  EditReminderEvent({
    this.oldReminder,
    this.time,
    this.title,
    this.note,
    this.priority,
    this.date,
    this.group,
    this.isDate,
    this.isTime,
  });
}
