import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/usecase/group_usecase.dart';
import 'package:ghichu/presentation/journey/group/add_list/add_list_constaner.dart';
import 'package:ghichu/presentation/view_state.dart';
import 'add_list_event.dart';
import 'add_list_state.dart';

class AddListBloc extends Bloc<AddListEvent, AddListState> {
  final GroupUseCase groupUseCase;

  AddListBloc({this.groupUseCase});
  @override
  AddListState get initialState => InitialAddListState(
      color: AddListConstants.listColors[4], index: 4, activeAddBtn: false);

  @override
  Stream<AddListState> mapEventToState(AddListEvent event) async* {
    if (event is PopAddListGroupEvent) {
      final currentState = state;
      yield PopAddListGroupState(isRemove: event.isRemove);
      yield currentState;
    }
    if (event is SelectColorEvent) {
      yield* _mapSelectColorEventToState(event);
    }
    if (event is ActiveAddBtn) {
      yield* _mapActiveAddBtn(event);
    }
    if (event is CreateListEvent) {
      yield* _mapCreateListEventToState(event);
    }
  }

  Stream<AddListState> _mapActiveAddBtn(ActiveAddBtn event) async* {
    final currentState = state;
    if (currentState is InitialAddListState) {
      if (event.text.trim().isEmpty) {
        yield currentState.update(activeAddBtn: false);
      } else {
        yield currentState.update(activeAddBtn: true);
      }
    }
  }

  Stream<AddListState> _mapCreateListEventToState(
      CreateListEvent event) async* {
    final currentState = state;
    if (currentState is InitialAddListState) {
      yield currentState.update(viewState: ViewState.loading);
      GroupEntity group = GroupEntity(
          name: event.name,
          color: event.color,
          createAt: event.createAt,
          lastUpdate: event.lastUpdate);
      int a = await groupUseCase.setGroup(group);
      if (a != null) {
        yield currentState.update(viewState: ViewState.success);
      }
    }
  }

  Stream<AddListState> _mapSelectColorEventToState(
      SelectColorEvent event) async* {
    final currentState = state;
    if (currentState is InitialAddListState) {
      final Color selectColor = event.color;
      final int indexSelect = event.indexSelect;
      yield currentState.update(selectColor: selectColor, index: indexSelect);
    }
  }
}
