import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/data/models/reminder.dart';
import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
import 'package:ghichu/presentation/journey/reminder/reminder_constants.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/check_box.dart';
import 'package:intl/intl.dart';

class ListReminder extends StatelessWidget {
  String title, group, note, keyGroup, keyDate, date;
  int createAt;
  bool time;
  Map<String, TextFiledController> controller;
  Reminder reminder;
  int indexReminder, indexGroup, index;
  ListReminder(
      {Key key,
      this.title,
      this.keyDate,
      this.indexReminder,
      this.group,
      this.note,
      this.date,
      this.indexGroup,
      this.time,
      this.controller,
      this.createAt,
      this.keyGroup,
      this.reminder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
      child: Row(
        children: [
          // Icon(Icons.check_circle_outlined),
          CheckBoxWidget(),
          SizedBox(
            width: ScreenUtil().setWidth(7),
          ),
          Expanded(
              child: GestureDetector(
            onTap: () {
              // if (allReminderBloc != null) {
              //   allReminderBloc.allReminderState.indexGroup = null;
              //   allReminderBloc.setIndexReminder(indexReminder, indexGroup);
              //   reminderUntil(
              //       type: ReminderEnum.All,
              //       allReminderBloc: allReminderBloc,
              //       controller: controller,
              //       keyGroup: keyGroup);
              // } else if (scheduleReminderBloc != null) {
              //   scheduleReminderBloc.scheduleReminderState.indexGroup = null;
              //   scheduleReminderBloc.setIndexReminder(
              //       indexReminder, indexGroup);
              //   reminderUntil(
              //       type: ReminderEnum.Schedule,
              //       controller: controller,
              //       scheduleReminderBloc: scheduleReminderBloc,
              //       keyGroup: 'Reminder',
              //       keyDate: keyDate);
              // } else {
              //   todayReminderBloc.todayReminderState.indexGroupReminder = 0;
              //   todayReminderBloc.setIndexReminder(indexReminder);
              // }
            },
            child: Container(
              padding:
                  EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black26))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$title',
                        style: ReminderContants.textStyleTitle,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
                      ),
                      // group == null
                      //     ? SizedBox()
                      //     : Row(
                      //         children: [
                      //           Text(
                      //             '$group',
                      //             style: ReminderContants.textStyleDateGroup,
                      //           ),
                      //           Visibility(
                      //               visible: time,
                      //               child: Text(
                      //                 ' - ${DateFormat('HH:mm').format(DateTime.fromMillisecondsSinceEpoch(date))}',
                      //                 style: ReminderContants.textStyleSchedule,
                      //               ))
                      //         ],
                      //       ),
                      group != null
                          ? SizedBox()
                          : Visibility(
                              visible: date == '' ? false : true,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(5),
                                  ),
                                  Text(
                                    date,
                                    style: ReminderContants.textStyleDateGroup,
                                  ),
                                ],
                              )),
                      Visibility(
                          visible: note == '' ? false : true,
                          child: Column(
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(7),
                              ),
                              Text(
                                '$note',
                                style: ReminderContants.textStyleNote,
                              )
                            ],
                          )),
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
                      )
                    ],
                  ),
                  // StreamBuilder(
                  //     initialData: allReminderBloc == null
                  //         ? scheduleReminderBloc == null
                  //             ? todayReminderBloc.todayReminderState
                  //             : scheduleReminderBloc.scheduleReminderState
                  //         : allReminderBloc.allReminderState,
                  //     stream: allReminderBloc == null
                  //         ? scheduleReminderBloc == null
                  //             ? todayReminderBloc.todayReminderController
                  //             : scheduleReminderBloc.streamController
                  //         : allReminderBloc.allController,
                  //     builder: (context, snapshot) {
                  //       return Padding(
                  //         padding:
                  //             EdgeInsets.only(right: ScreenUtil().setWidth(15)),
                  //         child: Visibility(
                  //             visible: indexGroup ==
                  //                     snapshot.data.indexGroupReminder
                  //                 ? indexReminder == snapshot.data.indexReminder
                  //                     ? true
                  //                     : false
                  //                 : false,
                  //             child: GestureDetector(
                  //               onTap: () {
                  //                 Navigator.pushNamed(
                  //                     context, RouteList.newReminder,
                  //                     arguments: {
                  //                       StringConstants.titleReminder: title,
                  //                       StringConstants.noteReminder: note,
                  //                       StringConstants.listGroup:
                  //                           ModelListReminder.myList.keys
                  //                               .toList(),
                  //                       StringConstants.isEdit: true,
                  //                       StringConstants.date: date,
                  //                       StringConstants.isTimeArg: time,
                  //                       StringConstants.listIndexArg: indexGroup
                  //                     });
                  //               },
                  //               child: Icon(
                  //                 Icons.error_outline,
                  //                 size: ScreenUtil().setSp(25),
                  //                 color: ReminderContants.colorIcon,
                  //               ),
                  //             )),
                  //       );
                  //     }),
                ],
              ),
            ),
          )),
        ],
      ),
    );
  }
}
