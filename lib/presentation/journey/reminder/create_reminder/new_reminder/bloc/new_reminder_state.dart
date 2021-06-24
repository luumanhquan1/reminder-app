import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_state.dart';
import 'package:ghichu/presentation/view_state.dart';

abstract class NewReminderState extends Equatable {}

class InitialNewReminderState extends NewReminderState {
  final bool isDateDetails, isTime;
  final ViewState viewState;
  final bool activeBtn;
  final GroupEntity groups;
  final int date;
  final InitDetailsState initDetailsState;
  final String timeDateDetails;
  InitialNewReminderState(
      {this.date,
        this.viewState,
      this.initDetailsState,
      this.timeDateDetails,
      this.isTime,
      this.isDateDetails,
      this.activeBtn,
      this.groups});
  InitialNewReminderState update({
    ViewState viewState,
    bool isDateDetails,
    InitDetailsState initDetailsState,
    String timeDateDetails,
    GroupEntity groups,
    bool isTime,
    bool activeBtn,
    int date,
  }) =>
      InitialNewReminderState(
        viewState: viewState??this.viewState,
          timeDateDetails: timeDateDetails ?? this.timeDateDetails,
          initDetailsState: initDetailsState ?? this.initDetailsState,
          isTime: isTime ?? this.isTime,
          date: date ,
          groups: groups ?? this.groups,
          isDateDetails: isDateDetails ?? this.isDateDetails,
          activeBtn: activeBtn ?? this.activeBtn);

  @override
  List<Object> get props => [
    this.viewState,
        this.timeDateDetails,
        this.initDetailsState,
        this.date,
        this.activeBtn,
        this.isDateDetails,
        this.groups,
        this.isTime
      ];
}

class PushToDetailState extends NewReminderState {
  final InitDetailsState initDetailsState;
  final String group;
  PushToDetailState({this.initDetailsState,this.group});
  @override
  List<Object> get props => [this.initDetailsState,this.group];
}

class PushToListGroupState extends NewReminderState {
  final GroupEntity groups;

  PushToListGroupState({this.groups});
  @override
  // TODO: implement props
  List<Object> get props => [];
}

