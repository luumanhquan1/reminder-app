import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/usecase/group_usecase.dart';
import 'package:ghichu/domain/usecase/reminder_usecase.dart';

import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/view_state.dart';
import 'package:ghichu/common/extension/extension_datetime.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GroupUseCase groupUs;
  final ReminderUseCase reminderUs;
  HomePageBloc({this.groupUs, this.reminderUs});
  @override
  // TODO: implement initialState
  HomePageState get initialState => InitHomePageState(
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
      final currentState = state;
      if (currentState is InitHomePageState) {
        yield currentState.update(isOpen: event.isOpen);
      }
    }
    if (event is DeleteGroupEvent) {
      yield* _mapDeleteGroupToState(event);
    }
    if (event is EditGroupEvent) {
      InitHomePageState cureentState;
      if (state is InitHomePageState) {
        cureentState = state;
      }
      yield EditGroupState(
          index: event.index, groupEntity: cureentState.keyMyList[event.index]);
      yield cureentState.update(isOpen: true);
    }
    if (event is UpdateEditGroupEvent) {
      yield* _mapUpdateEditGroupToState(event);
    }
    if (event is PushMyListEvent) {
      InitHomePageState creentState = state;
      if (creentState.isEdit == true) {
        yield PushMyListState(groupEntity: event.groupEntity,listGroup: creentState.keyMyList);
        yield creentState;
      }
    }
    if (event is PushAddGroupEvent) {
      InitHomePageState creentState = state;
      yield PushAddGroupState();
      yield creentState;
    }
    if (event is PushNewReminderEvent) {
      InitHomePageState creentState = state;
      yield PushNewReminderState(listGroup: event.listGroup);
      yield creentState;
    }
  }

  Stream<HomePageState> _mapUpdateEditGroupToState(
      UpdateEditGroupEvent event) async* {
    final currentState = state;
    if (currentState is InitHomePageState) {
      List<GroupEntity> listGroup = await groupUs.getUnitList();
      Map<String, int> reminderToGroup =
          await reminderUs.getLeghtReminderToGroupLocal(listGroup);
      yield currentState.update(
          keyMyList: listGroup, remindertoGroup: reminderToGroup);
    }
  }

  Stream<HomePageState> _mapDeleteGroupToState(DeleteGroupEvent event) async* {
    final creentState = state;
    if (creentState is InitHomePageState) {
      if (event.isDialog == false) {
        if (creentState
                .remindertoGroup[creentState.keyMyList[event.index].name] >
            0) {
          //kiểm tra trong group có reminder không? nếu có hiện dialog
          yield creentState.update(
              viewState: ViewState.showDiglog, index: event.index,);
          yield creentState.update(viewState: ViewState.initial, isOpen: true);
        } else {
          //trong group không có reminder
          await groupUs.deleteGroupLocal(event.index);
          creentState.keyMyList.removeAt(event.index);
          yield* isEmptyGroup(creentState, groupUs);
        }
      } else {
        //ấn xóa ở dialog khi có reminder mới hiện dialog

        await groupUs.deleteGroupLocal(event.index);
        await reminderUs
            .deleteReminderToGroup(creentState.keyMyList[event.index].name);
        creentState.keyMyList.removeAt(event.index);
        yield* isEmptyGroup(creentState, groupUs);
        yield* _mapUpDateReminderToState(UpDateReminderEvent());
      }
    }
  }

  Stream<HomePageState> _mapUpDateGroupToState(UpDateGroupEvent event) async* {
    final currentState = state;
    if (currentState is InitHomePageState) {
      List<GroupEntity> listGroup = await groupUs.getUnitList();
      currentState.remindertoGroup
          .addAll({listGroup[listGroup.length - 1].name: 0});
      yield currentState.update(
          keyMyList: listGroup, remindertoGroup: currentState.remindertoGroup);
    }
  }

  Stream<HomePageState> _mapUpDateReminderToState(
      UpDateReminderEvent event) async* {
    final currentState = state;
    if (currentState is InitHomePageState) {
      Map<String, int> reminderToGroup =
          await reminderUs.getLeghtReminderToGroupLocal(currentState.keyMyList);
      int scheduleLenght = await reminderUs.getLengthScheduledLocal();
      int toDayLenght = await reminderUs
          .getLenghtToDayReminderLocal(DateTime.now().dateTimeFormat());
      int allLenght = await reminderUs.getLenghtAllReminderLocal();
      yield currentState.update(
          reminderToday: toDayLenght,
          reminderAll: allLenght,
          remindertoGroup: reminderToGroup,
          reminderScheduled: scheduleLenght);
    }
  }

  Stream<HomePageState> _mapOrderGroupSystemToState(
      OrderGroupSystemEvent event) async* {
    final currentState = state;
    if (currentState is InitHomePageState) {
      bool isUpdate = !currentState.updateOrder;
      var item = currentState.reminderSystem.removeAt(event.oldIndex);
      currentState.reminderSystem.insert(event.newIndex, item);

      yield currentState.update(
          reminderSystem: currentState.reminderSystem, updateOrder: isUpdate);
    }
  }

  Stream<HomePageState> _mapEditToState(EditEvent event) async* {
    final currentState = state;
    if (currentState is InitHomePageState) {
      bool isOpen, isEdit;
      if (currentState.isOpen == false) {
        isOpen = true;
        if (currentState.isEdit == false) {
          isEdit = !currentState.isEdit;
        }
      } else {
        isEdit = !currentState.isEdit;
      }
      yield currentState.update(isEdit: isEdit, isOpen: isOpen);
    }
  }

  Stream<HomePageState> _mapOrderGroup(OrderGroupEvent orderGroup) async* {
    final currentState = state;
    if (currentState is InitHomePageState) {
      bool isUpdate = !currentState.updateOrder;
      var item = currentState.keyMyList.removeAt(orderGroup.oldIndex);
      currentState.keyMyList.insert(orderGroup.newIndex, item);
      yield currentState.update(
          keyMyList: currentState.keyMyList, updateOrder: isUpdate);
      await groupUs.orderGroupLocal(currentState.keyMyList);
    }
  }

  Stream<HomePageState> _mapUpdataHomePageToState(UpDate upDate) async* {
    final currentState = state;
    if (currentState is InitHomePageState) {
      List<GroupEntity> listGroup = await groupUs.getUnitList();
      Map<String, int> reminderToGroup =
          await reminderUs.getLeghtReminderToGroupLocal(listGroup);
      int scheduleLenght = await reminderUs.getLengthScheduledLocal();
      int toDayLenght = await reminderUs
          .getLenghtToDayReminderLocal(DateTime.now().dateTimeFormat());
      int allLenght = await reminderUs.getLenghtAllReminderLocal();
      yield currentState.update(
          reminderToday: toDayLenght,
          reminderAll: allLenght,
          keyMyList: listGroup,
          remindertoGroup: reminderToGroup,
          reminderScheduled: scheduleLenght);
    }
  }

  Stream<HomePageState> isEmptyGroup(
      InitHomePageState state, GroupUseCase groupUs) async* {
    if (state.keyMyList.isEmpty) {
      yield state.update(keyMyList: [], updateOrder: !state.updateOrder);
      List<GroupEntity> listGroup = await groupUs.getUnitList();
      await Future.delayed(Duration(milliseconds: 700));
      yield state.update(
        keyMyList: listGroup,
        updateOrder: !state.updateOrder,
        isOpen: true,
      );
    } else {
      yield state.update(
        keyMyList: state.keyMyList,
        updateOrder: !state.updateOrder,
        isOpen: true,
      );
    }
  }
}
