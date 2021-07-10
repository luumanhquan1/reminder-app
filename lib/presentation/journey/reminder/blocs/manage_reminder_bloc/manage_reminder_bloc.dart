import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/domain/usecase/reminder_usecase.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_event.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';

class ManageReminderBloc
    extends Bloc<ManageReminderEvent, ManageReminderState> {
  final ReminderUseCase reminderUC;

  ManageReminderBloc({this.reminderUC});

  @override
  // TODO: implement initialState
  ManageReminderState get initialState => InitManagerReminderState(
      listReminder: {},
      listGroup: [],
      isChangeState: false,
      isUpDate: false,
      reminderGroupOrToday: []);

  @override
  Stream<ManageReminderState> mapEventToState(
      ManageReminderEvent event) async* {
    if (event is GetDataReminderAllEvent) {
      yield* _mapGetDateReminderAll(event);
    }
    if (event is GetDataScheduledEvent) {
      yield* _mapGetDateReminderSchedule(event);
    }
    if (event is GetDateToDayEvent) {
      yield* _mapGetReminderToDayState(event);
    }
    if (event is GetDateGroupEvent) {
      yield* _mapGetReminderGroup(event);
    }
    if (event is EditReminderEvent) {
      InitManagerReminderState creentState;
      if (state is InitManagerReminderState) {
        creentState = state;
      }
      GroupEntity groupEntity;
      for (int i = 0; i < creentState.listGroup.length; i++) {
        if (creentState.listGroup[i].name == event.group) {
          groupEntity = creentState.listGroup[i];
          break;
        }
      }
      yield EditReminderState(
          reminderEntity: event.reminderEntity,
          listGroup: creentState.listGroup,
          groupEntity: groupEntity);
      yield creentState;
    }
    if (event is DeleteReminderEvent) {
      yield* _mapDeleteReminderState(event);
    }
  }

  Stream<ManageReminderState> _mapDeleteReminderState(
      DeleteReminderEvent event) async* {
    final creentState = state;
    await reminderUC.deleteReminder(event.reminderEntity);
    if (creentState is InitManagerReminderState) {

      if (creentState.listReminder.length == 0) {
        creentState.reminderGroupOrToday.removeAt(event.index);
        yield creentState.update(
            reminderGroupOrToday: creentState.reminderGroupOrToday,
            isUpDate: !creentState.isUpDate,
            isChangeState: true);
      } else {
        creentState.listReminder[event.reminderEntity.list]
            .removeAt(event.index);
        yield creentState.update(
            listReminder: creentState.listReminder,
            isUpDate: !creentState.isUpDate,
            isChangeState: true);
      }
    }
  }

  Stream<ManageReminderState> _mapGetReminderToDayState(
      GetDateToDayEvent event) async* {
    final creentState = state;
    if (creentState is InitManagerReminderState) {
      List<ReminderEntity> listReminder = await reminderUC.getReminderToDay();

      yield creentState.update(
          reminderGroupOrToday: listReminder, listGroup: event.listGroup);
    }
  }

  Stream<ManageReminderState> _mapGetReminderGroup(
      GetDateGroupEvent event) async* {
    final creentState = state;
    if (creentState is InitManagerReminderState) {
      List<ReminderEntity> listReminder =
          await reminderUC.getReminderToGroup(group: event.groupEntity.name);

      yield creentState.update(
          reminderGroupOrToday: listReminder, listGroup: event.listGroup);
    }
  }

  Stream<ManageReminderState> _mapGetDateReminderSchedule(
      GetDataScheduledEvent event) async* {
    final creentState = state;
    if (creentState is InitManagerReminderState) {
      Map<String, List<ReminderEntity>> listReminder =
          await reminderUC.getReminderScheduled();

      yield creentState.update(
          listReminder: listReminder, listGroup: event.listGroup);
    }
  }

  Stream<ManageReminderState> _mapGetDateReminderAll(
      GetDataReminderAllEvent event) async* {
    final creentState = state;
    if (creentState is InitManagerReminderState) {
      Map<String, List<ReminderEntity>> listReminder =
          await reminderUC.getReminderAll(event.listGroup);

      yield creentState.update(
          listReminder: listReminder, listGroup: event.listGroup);
    }
  }
}
