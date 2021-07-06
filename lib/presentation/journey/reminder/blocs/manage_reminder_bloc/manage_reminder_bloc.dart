
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
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
  ManageReminderState get initialState => ManageReminderState(
      listReminder: {}, listGroup: [], isChangeState: false);

  @override
  Stream<ManageReminderState> mapEventToState(
      ManageReminderEvent event) async* {
    if (event is GetDataReminderAllEvent) {
      yield* _mapGetDateReminderAll(event);
    }
    if (event is GetDataScheduled) {
      yield* _mapGetDateReminderSchedule(event);
    }
  }

  Stream<ManageReminderState> _mapGetDateReminderSchedule(
      GetDataScheduled event) async* {

    Map<String, List<ReminderEntity>> listReminder =
        await reminderUC.getReminderScheduled();
    log('$listReminder');
    yield state.update(listReminder: listReminder);
  }

  Stream<ManageReminderState> _mapGetDateReminderAll(
      GetDataReminderAllEvent event) async* {
    Map<String, List<ReminderEntity>> listReminder =
        await reminderUC.getReminderAll(event.listGroup);

    yield state.update(listReminder: listReminder, listGroup: event.listGroup);
  }
}
