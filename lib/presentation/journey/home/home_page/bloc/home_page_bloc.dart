import 'dart:async';
import 'dart:developer';
import 'package:ghichu/common/extension/extension_datetime.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/domain/usecase/group_usecase.dart';
import 'package:ghichu/domain/usecase/reminder_usecase.dart';

import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GroupUseCase groupUs;
  final ReminderUseCase reminderUs;
  HomePageBloc({this.groupUs, this.reminderUs});
  @override
  // TODO: implement initialState
  HomePageState get initialState => HomePageState(
      reminderScheduled: 0,
      reminderToday: 0,
      reminderAll: 0,
      keyMyList: [],
      updateOrder: true,
      isEdit: true,
      reminderSystem: ['Today', 'Scheduled', 'All']);
  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is UpDate) {
      yield* _mapUpdataHomePageToState(event);
    }
    if (event is UpDateGroupEvent) {
      yield* _mapUpDateGroupToState(event);
    }
    if (event is UpDateReminderEvent) {
      yield* _mapUpDateReminderToState(event);
    }
    if (event is OrderGroupEvent) {
      yield* _mapOrderGroup(event);
    }
    if (event is OrderGroupSystemEvent) {
      yield* _mapOrderGroupSystemToState(event);
    }
    if (event is EditEvent) {
      yield* _mapEditToState(event);
    }
  }

  Stream<HomePageState> _mapUpDateGroupToState(UpDateGroupEvent event) async* {
    final currentState = state;
    if (currentState is HomePageState) {
      List<GroupEntity> listGroup = await groupUs.getUnitList();
      currentState.remindertoGroup.addAll(
          {listGroup[listGroup.length - 1].name: <ReminderEntity>[].toList()});
      yield currentState.update(
          keyMyList: listGroup, remindertoGroup: state.remindertoGroup);
    }
  }

  Stream<HomePageState> _mapUpDateReminderToState(
      UpDateReminderEvent event) async* {
    final currentState = state;
    if (currentState is HomePageState) {
      String toDay = DateTime.now().dateTimeFormat();
      Map<String, List<ReminderEntity>> listReminderToGroup =
          await reminderUs.getReminderToGroup(state.keyMyList);
      Map<String, List<ReminderEntity>> listReminderToScheduled =
          await reminderUs.getReminderScheduled();
      int reminderAll = 0;
      int reminderToDay = listReminderToScheduled[toDay].length;
      int reminderScheduled = 0;
      listReminderToScheduled.forEach((key, value) {
        if (key != null) {
          reminderScheduled = reminderScheduled + value.length;
        }
      });
      listReminderToGroup.forEach((key, value) {
        reminderAll = reminderAll + value.length;
      });
      yield currentState.update(
          reminderAll: reminderAll,
          reminderToday: reminderToDay,
          reminderScheduled: reminderScheduled);
    }
  }

  Stream<HomePageState> _mapOrderGroupSystemToState(
      OrderGroupSystemEvent event) async* {
    bool isUpdate = !state.updateOrder;
    var item = state.reminderSystem.removeAt(event.oldIndex);
    state.reminderSystem.insert(event.newIndex, item);

    yield state.update(
        reminderSystem: state.reminderSystem, updateOrder: isUpdate);
  }

  Stream<HomePageState> _mapEditToState(EditEvent event) async* {
    bool isEdit = !event.isEdit;
    yield state.update(isEdit: isEdit);
  }

  Stream<HomePageState> _mapOrderGroup(OrderGroupEvent orderGroup) async* {
    bool isUpdate = !state.updateOrder;
    var item = state.keyMyList.removeAt(orderGroup.oldIndex);
    state.keyMyList.insert(orderGroup.newIndex, item);
    yield state.update(keyMyList: state.keyMyList, updateOrder: isUpdate);
    await groupUs.orderGroupLocal(state.keyMyList);
  }

  Stream<HomePageState> _mapUpdataHomePageToState(UpDate upDate) async* {
    List<GroupEntity> listGroup = await groupUs.getUnitList();
    String toDay = DateTime.now().dateTimeFormat();
    Map<String, List<ReminderEntity>> listReminderToGroup =
        await reminderUs.getReminderToGroup(listGroup);
    Map<String, List<ReminderEntity>> listReminderToScheduled =
        await reminderUs.getReminderScheduled();
    int reminderAll = 0;
    int reminderToDay = listReminderToScheduled[toDay].length;
    int reminderScheduled = 0;
    listReminderToScheduled.forEach((key, value) {
      if (key != null) {
        reminderScheduled = reminderScheduled + value.length;
      }
    });
    listReminderToGroup.forEach((key, value) {
      reminderAll = reminderAll + value.length;
    });
    yield state.update(
        reminderToday: reminderToDay,
        reminderScheduled: reminderScheduled,
        keyMyList: listGroup,
        remindertoGroup: listReminderToGroup,
        reminderAll: reminderAll);
  }
}
