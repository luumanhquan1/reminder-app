import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/presentation/view_state.dart';

// ignore: must_be_immutable
abstract class HomePageState extends Equatable {}

class InitHomePageState extends HomePageState {
  ViewState viewState;

  List<GroupEntity> keyMyList = [];
  bool updateOrder;
  int reminderToday, reminderScheduled, reminderAll;
  bool isEdit, isOpen;
  int index;
  List<String> reminderSystem = [];
  Map<String, List<ReminderEntity>> remindertoGroup;
  InitHomePageState(
      {this.keyMyList,
      this.index,
      this.viewState,
      this.isOpen,
      this.reminderScheduled,
      this.reminderToday,
      this.reminderAll,
      this.updateOrder,
      this.remindertoGroup,
      this.isEdit,
      this.reminderSystem});
  InitHomePageState update(
          {List<GroupEntity> keyMyList,
          int index,
          List<String> reminderSystem,
          bool updateOrder,
          int reminderToday,
          ViewState viewState,
          reminderScheduled,
          reminderAll,
          bool isEdit,
          isOpen,
          Map<String, List<ReminderEntity>> remindertoGroup}) =>
      InitHomePageState(
          index: index ?? this.index,
          viewState: viewState ?? this.viewState,
          isOpen: isOpen ?? this.isOpen,
          reminderAll: reminderAll ?? this.reminderAll,
          reminderScheduled: reminderScheduled ?? this.reminderScheduled,
          reminderToday: reminderToday ?? this.reminderToday,
          reminderSystem: reminderSystem ?? this.reminderSystem,
          isEdit: isEdit ?? this.isEdit,
          keyMyList: keyMyList ?? this.keyMyList,
          updateOrder: updateOrder ?? this.updateOrder,
          remindertoGroup: remindertoGroup ?? this.remindertoGroup);
  @override
  // TODO: implement props
  List<Object> get props => [
        this.index,
        this.viewState,
        this.isOpen,
        this.isEdit,
        this.keyMyList,
        this.updateOrder,
        this.remindertoGroup,
        this.reminderSystem,
        this.reminderScheduled,
        this.reminderToday,
        this.reminderAll
      ];
}

class EditGroupState extends HomePageState {
  final GroupEntity groupEntity;

  EditGroupState({@required this.groupEntity});
  @override
  List<Object> get props => [this.groupEntity];
}
