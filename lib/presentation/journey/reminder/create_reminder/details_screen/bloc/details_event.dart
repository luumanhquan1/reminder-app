import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_state.dart';

abstract class DetailsEvent {}

class DateSwitchEvent extends DetailsEvent {
  final bool isDateSwitch;
  DateSwitchEvent({@required this.isDateSwitch});
}

class UpDateStateDetailsEvent extends DetailsEvent {
  final InitDetailsState state;

  UpDateStateDetailsEvent({this.state});
}

class IsShowDateTableCanlenderEvent extends DetailsEvent {
  final bool isShowDateTableCanlender;

  IsShowDateTableCanlenderEvent({this.isShowDateTableCanlender});
}

class TimeSwitchEvent extends DetailsEvent {
  final bool isTimeSwitch;
  TimeSwitchEvent({@required this.isTimeSwitch});
}

class IsShowTimeTableEvent extends DetailsEvent {
  final bool isShowTimeTable;
  IsShowTimeTableEvent({this.isShowTimeTable});
}

class SelectDate extends DetailsEvent {
  final DateTime selectDate;
  SelectDate(this.selectDate);
}

class SelectTime extends DetailsEvent {
  final TimeOfDay timeOfDay;

  SelectTime(this.timeOfDay);
}

class UpDatePriorityEvent extends DetailsEvent {
  final String priority;
  final int indexSelect;
  UpDatePriorityEvent({this.priority, this.indexSelect});
}

class PushPrioritiesEvent extends DetailsEvent {
  final int index;
  PushPrioritiesEvent({this.index});
}

class AddReminderDetailsEvent extends DetailsEvent {
  final String title, note, group;

  AddReminderDetailsEvent({this.title, this.note, this.group});
}
