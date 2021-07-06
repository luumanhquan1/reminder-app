import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_event.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';

class ManageReminderBloc extends Bloc<ManageReminderEvent,ManageReminderState>{
  @override
  // TODO: implement initialState
  ManageReminderState get initialState => ManageReminderState();

  @override
  Stream<ManageReminderState> mapEventToState(ManageReminderEvent event) {
    // TODO: implement mapEventToState
    throw UnimplementedError();
  }


}