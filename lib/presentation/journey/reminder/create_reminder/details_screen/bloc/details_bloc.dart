import 'dart:developer';
import 'package:ghichu/domain/usecase/reminder_usecase.dart';
import 'package:ghichu/presentation/view_state.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/domain/entities/details_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_event.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_state.dart';
import 'package:ghichu/common/extension/extension_datetime.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  final ReminderUseCase reminderUseCase;

  DetailsBloc({this.reminderUseCase});
  @override
  // TODO: implement initialState
  DetailsState get initialState => InitDetailsState(
      isDateSwitch: false,
      isTimeSwitch: false,
      priority: 'Không có',
      isDateTableCanlender: false,
      isTimeTable: false,
      selectDate: DateTime.now(),
      timeOfDay: TimeOfDay.now());

  @override
  Stream<DetailsState> mapEventToState(DetailsEvent event) async* {
    if (event is UpDatePriorityEvent) {
      final currentState = state;
      if (currentState is InitDetailsState) {
        yield currentState.update(
            priority: event.priority, indexSelect: event.indexSelect);
      }
    }
    if (event is AddReminderDetailsEvent) {
      yield* _mapAddReminderToState(event);
    }
    if (event is UpDateStateDetailsEvent) {
      final current = state;
      if (current is InitDetailsState) {
        yield event.state ?? current;
      }
    }
    if (event is DateSwitchEvent) {
      yield* _mapDateSwitchToState(event);
    }
    if (event is TimeSwitchEvent) {
      yield* _mapTimeSwitchToState(event);
    }
    if (event is IsShowDateTableCanlenderEvent) {
      yield* _mapIsShowDateTableToState(event);
    }
    if (event is IsShowTimeTableEvent) {
      yield* _mapIsShowTimeTableToState(event);
    }
    if (event is SelectDate) {
      yield* _mapSelectDateToState(event);
    }
    if (event is SelectTime) {
      yield* _mapSelectTimeToState(event);
    }
    if (event is PushPrioritiesEvent) {
      yield* _mapPushPrioritiesToState(event);
    }
  }

  Stream<DetailsState> _mapAddReminderToState(
      AddReminderDetailsEvent event) async* {
    final currentState = state;
    if (currentState is InitDetailsState) {
      String date;
      String time;
      if (currentState.isDateSwitch) {
        date = currentState.selectDate.dateTimeFormat();
        if (currentState.isTimeSwitch) {
          int h = currentState.timeOfDay.hour * 60 * 60 * 1000 +
              currentState.timeOfDay.minute * 60 * 1000 +
              DateTime.parse(DateTime.now().dateTimeFormat())
                  .millisecondsSinceEpoch;
          time = DateFormat('HH-mm')
              .format(DateTime.fromMillisecondsSinceEpoch(h));
        } else {
          time = null;
        }
      } else {
        date = null;
      }
      DetailsEntity detailsEntity = DetailsEntity(
          date: date, time: time, priority: currentState.priority);
      ReminderEntity reminderEntity = ReminderEntity(
          title: event.title,
          note: event.note,
          details: detailsEntity,
          list: event.group,
          createAt: DateTime.now().toString(),
          lastUpdate: DateTime.now().toString());
      if (reminderUseCase.addReminder(reminderEntity) != null) {
        yield currentState.update(viewState: ViewState.success);
      }
    }
  }

  Stream<DetailsState> _mapPushPrioritiesToState(
      PushPrioritiesEvent event) async* {
    InitDetailsState currentState;
    if (state is InitDetailsState) {
      currentState = state;
    }
    yield PushPrioritiesState(indexSelect: event.index);
    yield currentState;
  }

  Stream<DetailsState> _mapSelectTimeToState(SelectTime event) async* {
    final current = state;
    if (current is InitDetailsState) {
      yield current.update(timeOfDay: event.timeOfDay);
    }
  }

  Stream<DetailsState> _mapSelectDateToState(SelectDate event) async* {
    final current = state;
    if (current is InitDetailsState) {
      yield current.update(selectDate: event.selectDate);
    }
  }

  Stream<DetailsState> _mapIsShowTimeTableToState(
      IsShowTimeTableEvent event) async* {
    final currentState = state;
    if (currentState is InitDetailsState) {
      bool isShowTimeTable;
      if (currentState.isTimeSwitch) {
        isShowTimeTable = !event.isShowTimeTable;
        yield currentState.update(isTimeTable: isShowTimeTable);
      }
    }
  }

  Stream<DetailsState> _mapIsShowDateTableToState(
      IsShowDateTableCanlenderEvent event) async* {
    final currentState = state;
    if (currentState is InitDetailsState) {
      bool isDateTableCanlender;
      if (currentState.isDateSwitch) {
        isDateTableCanlender = !event.isShowDateTableCanlender;
        yield currentState.update(isDateTableCanlender: isDateTableCanlender);
      }
    }
  }

  Stream<DetailsState> _mapDateSwitchToState(DateSwitchEvent event) async* {
    final currentState = state;
    DateTime nowDateTime;
    if (currentState is InitDetailsState) {
      bool isTimeSwitch, isDateTableCanlender, isTimeTable;
      if (event.isDateSwitch == false) {
        isTimeSwitch = false;
        isDateTableCanlender = false;
        isTimeTable = false;
        nowDateTime = null;
      } else {
        isDateTableCanlender = true;
        nowDateTime = DateTime.now();
      }
      yield currentState.update(
          isDateSwitch: event.isDateSwitch,
          isTimeSwitch: isTimeSwitch,
          isTimeTable: isTimeTable,
          isDateTableCanlender: isDateTableCanlender,
          selectDate: nowDateTime);
    }
  }

  Stream<DetailsState> _mapTimeSwitchToState(TimeSwitchEvent event) async* {
    final currentState = state;
    if (currentState is InitDetailsState) {
      bool isDateSwitch, isTimeTable;
      if (event.isTimeSwitch) {
        isDateSwitch = true;
        isTimeTable = true;
      } else {
        isTimeTable = false;
      }
      yield currentState.update(
          isTimeSwitch: event.isTimeSwitch,
          isDateSwitch: isDateSwitch,
          isTimeTable: isTimeTable);
    }
  }
}
