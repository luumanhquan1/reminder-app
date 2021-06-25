import 'package:equatable/equatable.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

// ignore: must_be_immutable
class HomePageState extends Equatable {
  List<GroupEntity> keyMyList = [];
  bool updateOrder;
  int reminderToday, reminderScheduled, reminderAll;
  bool isEdit,isOpen;
  List<String> reminderSystem = [];
  Map<String, List<ReminderEntity>> remindertoGroup;
  HomePageState(
      {this.keyMyList,
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
          List<String> reminderSystem,
          bool updateOrder,
          int reminderToday,

          reminderScheduled,
          reminderAll,
          bool isEdit,isOpen,
          Map<String, List<ReminderEntity>> remindertoGroup}) =>
      HomePageState(
        isOpen: isOpen??this.isOpen,
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
