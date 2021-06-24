import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/create_reminder_constants.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_event.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_state.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:ghichu/common/extension/extension_datetime.dart';

// ignore: must_be_immutable
class TimeWidget extends StatelessWidget {
  TimeOfDay pickedTime;
  InitDetailsState state;
  TimeWidget({Key key, this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            detailsSwitch(
              state: state,
              isTime: false,
              title: CreateReminderConstants.detailsSwitchDate,
              isPicker: () {
                BlocProvider.of<DetailsBloc>(context).add(
                    IsShowDateTableCanlenderEvent(
                        isShowDateTableCanlender: state.isDateTableCanlender));
              },
              isSwitch: (value) {
                BlocProvider.of<DetailsBloc>(context)
                    .add(DateSwitchEvent(isDateSwitch: value));
              },
            ),
            Visibility(
                visible: state.isDateTableCanlender,
                child: TableCalendar(
                  daysOfWeekHeight: ScreenUtil().setHeight(20),
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: DateTime.now(),
                  selectedDayPredicate: (day) {
                    return isSameDay(state.selectDate, day);
                  },
                  onDaySelected: (date, focusdate) {
                    BlocProvider.of<DetailsBloc>(context).add(SelectDate(date));
                  },
                )),
            detailsSwitch(
              state: state,
              isTime: true,
              title: CreateReminderConstants.detailsSwitchTime,
              isPicker: () {
                BlocProvider.of<DetailsBloc>(context).add(
                    IsShowTimeTableEvent(isShowTimeTable: state.isTimeTable));
              },
              isSwitch: (values) {
                BlocProvider.of<DetailsBloc>(context)
                    .add(TimeSwitchEvent(isTimeSwitch: values));
              },
            ),
            Visibility(
              visible: state.isTimeTable,
              child: Container(
                margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(10)),
                width: double.infinity,
                height: ScreenUtil().setHeight(50),
                color: Colors.transparent,
                padding: EdgeInsets.only(right: ScreenUtil().setWidth(20)),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () async {
                      pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      BlocProvider.of<DetailsBloc>(context)
                          .add(SelectTime(pickedTime));
                    },
                    child: Container(
                      width: ScreenUtil().setWidth(60),
                      height: ScreenUtil().setHeight(35),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(7))),
                      child: Text(
                        '${state.timeOfDay.hour}:${state.timeOfDay.minute}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(20)),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget detailsSwitch(
      {@required InitDetailsState state,
      @required bool isTime,
      @required String title,
      @required Function isPicker,
      @required Function isSwitch}) {
    return Row(
      children: [
        SizedBox(
          width: ScreenUtil().setWidth(10),
        ),
        Container(
          height: CreateReminderConstants.detailsSwitchSizeIcon,
          width: CreateReminderConstants.detailsSwitchSizeIcon,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Center(
            child: Icon(
              CreateReminderConstants.detailsIcon,
              color: Colors.white,
              size: CreateReminderConstants.sizeIcon,
            ),
          ),
        ),
        SizedBox(
          width: ScreenUtil().setWidth(10),
        ),
        Expanded(
            child: GestureDetector(
                onTap: isPicker,
                child: Container(
                  height: CreateReminderConstants.heightContainer,
                  decoration: BoxDecoration(
                      border:
                          Border(bottom: BorderSide(color: Colors.black12))),
                  child: Padding(
                    padding: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(title,
                                style: CreateReminderConstants.textStyleDate),
                            isTime
                                ? Visibility(
                                    visible: state.isTimeSwitch,
                                    child: Text(
                                      '${state.timeOfDay.hour}:${state.timeOfDay.minute}',
                                      style: CreateReminderConstants
                                          .textStyleTimer,
                                    ))
                                : Visibility(
                                    visible: state.isDateSwitch,
                                    child: Text(
                                      state.selectDate.getDateOnString,
                                      style: CreateReminderConstants
                                          .textStyleTimer,
                                    ))
                          ],
                        ),
                        FlutterSwitch(
                          height: CreateReminderConstants.heightSwitch,
                          width: CreateReminderConstants.witdhSwitch,
                          toggleSize: CreateReminderConstants.toggleSizeSwitch,
                          borderRadius:
                              CreateReminderConstants.borderRadiusSwitch,
                          activeColor: Colors.green,
                          value:
                              isTime ? state.isTimeSwitch : state.isDateSwitch,
                          onToggle: isSwitch,
                        )
                      ],
                    ),
                  ),
                )))
      ],
    );
  }
}
