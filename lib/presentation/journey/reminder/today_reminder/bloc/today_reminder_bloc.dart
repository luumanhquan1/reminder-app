import 'dart:async';

import 'package:ghichu/presentation/journey/reminder/today_reminder/bloc/today_reminder_state.dart';
import 'package:intl/intl.dart';

class TodayReminderBloc {
  TodayReminderState todayReminderState = TodayReminderState(
      nowDate: DateFormat('yyyy-MM-dd').format(DateTime.now()));
  StreamController _todayReminderController =
      StreamController<TodayReminderState>.broadcast();

  Stream get todayReminderController => _todayReminderController.stream;
  void getToday() {
    todayReminderState.getToday();
    _todayReminderController.sink.add(todayReminderState);
  }
void setIndexReminder(int index){
    todayReminderState.setIndexReminder(index);
    _todayReminderController.sink.add(todayReminderState);
}
void update(){
    _todayReminderController.sink.add(todayReminderState);
}
  void dispose() {
    _todayReminderController.close();
  }
}
