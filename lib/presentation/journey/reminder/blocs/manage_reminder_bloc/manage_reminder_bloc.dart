import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/domain/entities/details_entity.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/domain/usecase/reminder_usecase.dart';
import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_event.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';

class ManageReminderBloc
    extends Bloc<ManageReminderEvent, ManageReminderState> {
  final ReminderUseCase reminderUC;
  bool isAllPage;
  ManageReminderBloc({this.reminderUC});

  @override
  // TODO: implement initialState
  ManageReminderState get initialState => InitManagerReminderState(
      listReminder: {},
      listController: {},
      indexGroup: -1,
      indexReminder: -1,
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
      yield* _mapEditReminderToState(event);
    }
    if (event is DeleteReminderEvent) {
      yield* _mapDeleteReminderState(event);
    }
    if (event is SelectReminderEvent) {
      yield* _mapSelectReminderToState(event);
    }
    if (event is AddControllerTextFieldEvent) {
      final creentState = state;
      if (creentState is InitManagerReminderState) {
        Map<String, TextFiledController> listController = {};
        for (int i = 0; i < creentState.listReminder.keys.length; i++) {
          listController.addAll({
            "$i": TextFiledController(
                textEditingController: TextEditingController(),
                focusNode: FocusNode())
          });
        }

        yield creentState.update(listController: listController);
      }
    }
    if (event is AddReminderEvent) {
     yield* _mapAddReminderToState(event);
    }
  }
Stream<ManageReminderState> _mapAddReminderToState(AddReminderEvent event)async*{
  final creentState = state;
  if (creentState is InitManagerReminderState) {
    int i = 0;
    int index;
    bool check = false;
    String title = '';
    creentState.listController.forEach((key, value) {
      if (value.textEditingController.text.trim().isNotEmpty) {
        check = true;
        title = value.textEditingController.text;
        value.textEditingController.text = '';
        index = i;
        value.focusNode.unfocus();
      }
      i++;
    });

    if (check) {
      if (isAllPage) {
        yield* addReminderState(
            title: title,
            group: creentState.listGroup[index].name,
            state: creentState);
      } else {
        yield* addReminderState(
            group: creentState.listGroup[0].name,
            title: title,
            date: creentState.listReminder.keys.elementAt(index),
            state: creentState);
      }
    }
  }
}
  Stream<ManageReminderState> _mapSelectReminderToState(
      SelectReminderEvent event) async* {
    final creentState = state;
    if (creentState is InitManagerReminderState) {
      yield creentState.update(
          indexGroup: event.indexGroup, indexReminder: event.indexReminder);
    }
  }

  Stream<ManageReminderState> addReminderState(
      {String title,
      String group,
      String date,
      InitManagerReminderState state}) async* {
    DetailsEntity detailsEntity =
        DetailsEntity(date: date, time: null, priority: 'none');
    ReminderEntity reminderEntity = ReminderEntity(
        title: title,
        note: '',
        details: detailsEntity,
        list: group,
        createAt: DateTime.now().toString(),
        lastUpdate: DateTime.now().toString());
    int result = await reminderUC.addReminder(reminderEntity);
    if (result != null) {
      if (isAllPage) {
        state.listReminder[group].add(reminderEntity);
      } else {
        state.listReminder[date].add(reminderEntity);
      }
      yield state.update(listReminder: state.listReminder, isChangeState: true);
    }
  }

  Stream<ManageReminderState> _mapEditReminderToState(
      EditReminderEvent event) async* {
    InitManagerReminderState creentState;
    if (state is InitManagerReminderState) {
      creentState = state;
    }
    GroupEntity groupEntity;
    for (int i = 0; i < creentState.listGroup.length; i++) {
      //tim group cho reminder
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
        if (isAllPage) {
          creentState.listReminder[event.reminderEntity.list]
              .removeAt(event.index);
        } else {
          creentState.listReminder[event.reminderEntity.details.date]
              .removeAt(event.index);
        }
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
    isAllPage = false;
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
    isAllPage = true;
    final creentState = state;
    if (creentState is InitManagerReminderState) {
      Map<String, List<ReminderEntity>> listReminder =
          await reminderUC.getReminderAll(event.listGroup);

      yield creentState.update(
          listReminder: listReminder, listGroup: event.listGroup);
    }
  }
}
