import 'package:equatable/equatable.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/presentation/view_state.dart';

// ignore: must_be_immutable
class HomePageState extends Equatable {
  ViewState viewState;
  Feature feature;
  List<GroupEntity> keyMyList = [];
  bool updateOrder;
  int reminderToday, reminderScheduled, reminderAll;
  bool isEdit, isOpen;
  int index;
  List<String> reminderSystem = [];
  Map<String, List<ReminderEntity>> remindertoGroup;
  HomePageState(
      {this.keyMyList,
      this.index,
      this.feature,
      this.viewState,
      this.isOpen,
      this.reminderScheduled,
      this.reminderToday,
      this.reminderAll,
      this.updateOrder,
      this.remindertoGroup,
      this.isEdit,
      this.reminderSystem});
  HomePageState update(
          {List<GroupEntity> keyMyList,
          int index,
          Feature feature,
          List<String> reminderSystem,
          bool updateOrder,
          int reminderToday,
          ViewState viewState,
          reminderScheduled,
          reminderAll,
          bool isEdit,
          isOpen,
          Map<String, List<ReminderEntity>> remindertoGroup}) =>
      HomePageState(
          feature: feature ?? this.feature,
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
        this.feature,
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
