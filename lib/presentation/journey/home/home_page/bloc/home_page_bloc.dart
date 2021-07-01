import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:ghichu/common/extension/extension_datetime.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/domain/usecase/group_usecase.dart';
import 'package:ghichu/domain/usecase/reminder_usecase.dart';

import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/view_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GroupUseCase groupUs;
  final ReminderUseCase reminderUs;
  HomePageBloc({this.groupUs, this.reminderUs});
  @override
  // TODO: implement initialState
  HomePageState get initialState => HomePageState(
      isOpen: true,
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
    if (event is SlideIsOpenEvent) {
      yield state.update(isOpen: event.isOpen);
    }
    if (event is DeleteGroupEvent) {
      yield* _mapDeleteGroupToState(event);
    }
    if(event is EditGroupEvent){
      yield state.update(feature: Feature.edit,index: event.index,isOpen: true);
      yield state.update(feature: Feature.initial);
    }
  }

  Stream<HomePageState> _mapDeleteGroupToState(DeleteGroupEvent event) async* {
    if (event.isDialog == false) {
      if (state.remindertoGroup[state.keyMyList[event.index].name].length > 0) {
        //kiểm tra trong group có reminder không? nếu có hiện dialog
        yield state.update(
            viewState: ViewState.showDiglog, index: event.index, isOpen: true);
      } else {
        //trong group không có reminder
        await groupUs.deleteGroupLocal(event.index);
      state.keyMyList.removeAt(event.index);
      yield* isEmptyGroup(state, groupUs);
    }
  } else {
  //ấn xóa ở dialog khi có reminder mới hiện dialog
  await groupUs.deleteGroupLocal(event.index);
      await reminderUs.deleteReminderToGroup(state.keyMyList[event.index].name);
      state.keyMyList.removeAt(event.index);
      yield* isEmptyGroup(state, groupUs);
      yield* _mapUpDateReminderToState(UpDateReminderEvent());
    }
  }

  Stream<HomePageState> _mapUpDateGroupToState(UpDateGroupEvent event) async* {
    final currentState = state;
    log('message');
    if (currentState is HomePageState) {
      List<GroupEntity> listGroup = await groupUs.getUnitList();
      // currentState.remindertoGroup.addAll(
      //     {listGroup[listGroup.length - 1].name: <ReminderEntity>[].toList()});
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
          remindertoGroup: listReminderToGroup,
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
    bool isOpen, isEdit;
    if (state.isOpen == false) {
      isOpen = true;
      if (state.isEdit == false) {
        isEdit = !state.isEdit;
      }
    } else {
      isEdit = !state.isEdit;
    }
    yield state.update(isEdit: isEdit, isOpen: isOpen);
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

  Stream<HomePageState> isEmptyGroup(
      HomePageState state, GroupUseCase groupUs) async* {
    if (state.keyMyList.isEmpty) {
      yield state.update(keyMyList: [], updateOrder: !state.updateOrder);
      List<GroupEntity> listGroup = await groupUs.getUnitList();
      await Future.delayed(Duration(milliseconds: 700));
      yield state.update(
          keyMyList: listGroup,
          updateOrder: !state.updateOrder,
          viewState: ViewState.initial);
    } else {
      yield state.update(
          keyMyList: state.keyMyList,
          updateOrder: !state.updateOrder,
          viewState: ViewState.initial);
    }
  }
}
