import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

import 'package:ghichu/presentation/view_state.dart';

// ignore: must_be_immutable
abstract class HomePageState extends Equatable {}

// ignore: must_be_immutable
class InitHomePageState extends HomePageState {
  ViewState viewState;
  Map<String, List<ReminderEntity>> listReminder;
  List<GroupEntity> keyMyList = [];
  bool updateOrder;
  int reminderToday, reminderScheduled, reminderAll;
  bool isEdit, isOpen, isSearch,isSearchTxtEmty;
  int index;
  List<String> reminderSystem = [];
  Map<String, int> remindertoGroup;
  InitHomePageState(
      {this.keyMyList,
        this.isSearchTxtEmty,
      this.index,
        this.listReminder,
      this.viewState,
      this.isOpen,
      this.reminderScheduled,
      this.reminderToday,
      this.reminderAll,
      this.isSearch,
      this.updateOrder,
      this.remindertoGroup,
      this.isEdit,
      this.reminderSystem});
  InitHomePageState update(
          {List<GroupEntity> keyMyList,
          int index,
          List<String> reminderSystem,
          bool updateOrder,
            Map<String, List<ReminderEntity>> listReminder,
          bool isSearch,isSearchTxtEmty,
          int reminderToday,
          ViewState viewState,
          reminderScheduled,
          reminderAll,
          bool isEdit,
          bool isOpen,
          Map<String, int> remindertoGroup}) =>
      InitHomePageState(
        listReminder: listReminder??this.listReminder,
        isSearchTxtEmty: isSearchTxtEmty??this.isSearchTxtEmty,
          isSearch: isSearch ?? this.isSearch,
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
    this.listReminder,
        this.isSearch,
    this.isSearchTxtEmty,
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
  final int index;
  EditGroupState({@required this.index, @required this.groupEntity});
  @override
  List<Object> get props => [this.groupEntity];
}

class PushMyListState extends HomePageState {
  final GroupEntity groupEntity;
  final List<GroupEntity> listGroup;
  PushMyListState({@required this.groupEntity, @required this.listGroup});
  @override
  // TODO: implement props
  List<Object> get props => [this.groupEntity, this.listGroup];
}

class PushAddGroupState extends HomePageState {
  @override
  List<Object> get props => [];
}

class PushNewReminderState extends HomePageState {
  final List<GroupEntity> listGroup;

  PushNewReminderState({this.listGroup});
  @override
  List<Object> get props => [this.listGroup];
}
class PushReminderSystemState extends HomePageState{
  final List<GroupEntity> listGroup;
  final String routeName;

  PushReminderSystemState({this.listGroup, this.routeName});

  @override

  List<Object> get props =>[this.listGroup,this.routeName];
}
class SearchReminderState extends HomePageState{
  @override

  List<Object> get props => throw UnimplementedError();

}
