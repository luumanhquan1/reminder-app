import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/domain/usecase/reminder_usecase.dart';
import 'package:ghichu/presentation/journey/reminder/all_reminder/bloc/all_reminder_event.dart';
import 'package:ghichu/presentation/journey/reminder/all_reminder/bloc/all_reminder_state.dart';

class AllReminderBloc extends Bloc<AllReminderEvent, AllReminderState> {
  final ReminderUseCase reminderUC;

  AllReminderBloc({@required this.reminderUC});
  @override
  // TODO: implement initialState
  AllReminderState get initialState => InitAllReminderState(listReminder: {});

  @override
  Stream<AllReminderState> mapEventToState(AllReminderEvent event) async* {
    if (event is GetDataReminderEvent) {
      yield* _mapGetDateReminder(event);
    }
  }

  Stream<AllReminderState> _mapGetDateReminder(
      GetDataReminderEvent event) async* {
    final creentState = state;
    if (creentState is InitAllReminderState) {
      Map<String, List<ReminderEntity>> listReminder =
          await reminderUC.getReminderAll(event.listGroup);
      log('$listReminder');
      yield creentState.update(listReminder: listReminder,listGroup: event.listGroup);
    }
  }
}
