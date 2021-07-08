import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/common/extension/extension_datetime.dart';
import 'package:ghichu/domain/entities/details_entity.dart';

import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';

import 'package:ghichu/domain/usecase/reminder_usecase.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/new_reminder/bloc/new_reminder_event.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/new_reminder/bloc/new_reminder_state.dart';
import 'package:ghichu/presentation/view_state.dart';
import 'package:intl/intl.dart';

class NewReminderBloc extends Bloc<NewReminderEvent, NewReminderState> {
  final ReminderUseCase reminderUseCase;

  NewReminderBloc({this.reminderUseCase});
  @override
  NewReminderState get initialState => InitialNewReminderState(
      groups: GroupEntity(),
      isDateDetails: false,
      activeBtn: false,
      isTime: false);

  @override
  Stream<NewReminderState> mapEventToState(NewReminderEvent event) async* {
    if (event is UpDateNewReminderDetailsEvent) {
      yield* _mapUpDateDetailsToState(event);
    }
    if (event is UpDateNewReminderListGroupEvent) {
      yield* _mapUpDateListGroupToState(event);
    }
    if (event is ActiveBtn) {
      yield* _mapActiveBtn(event);
    }
    if (event is PushDetailEvent) {
      InitialNewReminderState current;
      if (state is InitialNewReminderState) {
        current = state;
      }
      yield PushToDetailState(
          initDetailsState: current.initDetailsState,
          group: current.groups.name);
      yield current;
    }
    if (event is PushListGroupEvent) {
      InitialNewReminderState current;
      if (state is InitialNewReminderState) {
        current = state;
      }
      yield PushToListGroupState(groups: current.groups);
      yield current;
    }
    if (event is AddReminderEvent) {
      yield* _mapAddReminderToState(event);
    }
    if (event is EditReminderEvent) {
      yield* _mapEditReminderToState(event);
    }
  }

  Stream<NewReminderState> _mapEditReminderToState(
      EditReminderEvent event) async* {

    final creentState = state;
    if (creentState is InitialNewReminderState) {
      String date, time;
      if (event.isDate) {
        date=event.date.dateTimeFormat();
        if(event.isTime){
          String hour,minute;
          if(event.time.hour<10){
            hour="0${event.time.hour}";
          }else{
            hour="${event.time.hour}";
          }
          if(event.time.minute<10){
            minute="0${event.time.minute}";
          }else{
            minute="${event.time.minute}";
          }
          time="$hour-$minute";
        }else{
          time=null;
        }
      } else {
        date = null;
        time = null;
      }
      yield creentState.update(viewState: ViewState.loading);
      DetailsEntity detailsEntity =
      DetailsEntity(date: date, time: time, priority: event.oldReminder.details.priority);
      ReminderEntity reminderEntity = ReminderEntity(
          title: event.title,
          note: event.note,
          details: detailsEntity,
          list: event.group,
          createAt: event.oldReminder.createAt,
          lastUpdate: DateTime.now().toString());
      await reminderUseCase.editReminder(event.oldReminder, reminderEntity);
      yield creentState.update(viewState: ViewState.success);
    }
  }

  Stream<NewReminderState> _mapAddReminderToState(
      AddReminderEvent event) async* {
    final currentState = state;
    if (currentState is InitialNewReminderState) {
      String date;
      String time;
      try {
        date = DateFormat('yyyy-MM-dd')
            .format(DateTime.fromMillisecondsSinceEpoch(event.date));
        if (DateTime.fromMillisecondsSinceEpoch(event.date).second == 0) {
          time = null;
        } else {
          time = DateFormat('HH-mm')
              .format(DateTime.fromMillisecondsSinceEpoch(event.date));
        }
      } catch (_) {
        date = null;
        time = null;
      }
      yield currentState.update(viewState: ViewState.loading);
      DetailsEntity detailsEntity =
          DetailsEntity(date: date, time: time, priority: event.priority);
      ReminderEntity reminderEntity = ReminderEntity(
          title: event.title,
          note: event.note,
          details: detailsEntity,
          list: event.group,
          createAt: DateTime.now().toString(),
          lastUpdate: DateTime.now().toString());
      if (reminderUseCase.addReminder(reminderEntity) != null) {
        yield currentState.update(viewState: ViewState.success);
      } else {
        yield currentState.update(viewState: ViewState.error);
      }
    }
  }

  Stream<NewReminderState> _mapUpDateDetailsToState(
      UpDateNewReminderDetailsEvent event) async* {
    String timeDatails = '';
    int date;
    final current = state;
    if (current is InitialNewReminderState) {
      date = event.initDetailsState.selectDate.getTimeInt(
          date: event.initDetailsState.isDateSwitch,
          time: event.initDetailsState.isTimeSwitch,
          hour: event.initDetailsState.timeOfDay.hour,
          minute: event.initDetailsState.timeOfDay.minute);
      timeDatails = event.initDetailsState.selectDate.getTimeDate(
          timeOfDay: event.initDetailsState.timeOfDay,
          isTimeSwitch: event.initDetailsState.isTimeSwitch,
          isDateSwitch: event.initDetailsState.isDateSwitch);
      yield current.update(
        date: date,
        timeDateDetails: timeDatails,
        initDetailsState: event.initDetailsState,
        isDateDetails: event.isDateDetails,
      );
    }
  }

  Stream<NewReminderState> _mapUpDateListGroupToState(
      UpDateNewReminderListGroupEvent event) async* {
    final currentState = state;
    if (currentState is InitialNewReminderState) {
      yield currentState.update(groups: event.groups);
    }
  }

  Stream<NewReminderState> _mapActiveBtn(ActiveBtn event) async* {
    final currentState = state;
    if (currentState is InitialNewReminderState) {
      yield currentState.update(activeBtn: event.activeBtn);
    }
  }
}
