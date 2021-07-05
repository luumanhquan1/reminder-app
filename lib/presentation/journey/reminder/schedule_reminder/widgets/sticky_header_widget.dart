// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/screen_util.dart';
// import 'package:ghichu/data/models/model_map.dart';
// import 'package:ghichu/data/models/reminder.dart';
// import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
// import 'package:ghichu/presentation/journey/reminder/schedule_reminder/bloc/schedule_reminder_bloc.dart';
// import 'package:ghichu/presentation/journey/reminder/widgets/add_widget.dart';
// import 'package:ghichu/presentation/journey/reminder/widgets/list_reminder.dart';
//
//
// import 'package:sticky_headers/sticky_headers/widget.dart';
// import 'package:intl/intl.dart';
//
// class StickyReminderSchedule extends StatelessWidget {
//   String title, keyDate;
//   int indexSticky;
//   int indexReminder;
//   Map<String, TextFiledController> controler;
//   ScheduleReminderBloc scheduleReminderBloc;
//   StickyReminderSchedule(
//       {Key key,
//       this.scheduleReminderBloc,
//       this.title,
//         this.keyDate,
//       this.indexSticky,
//       this.controler,
//       this.indexReminder})
//       : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return StickyHeader(
//         overlapHeaders: false,
//         header: Container(
//           height: ScreenUtil().setHeight(45),
//           width: ScreenUtil().screenWidth,
//           color: Colors.white,
//           padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
//           alignment: Alignment.centerLeft,
//           child: Text(
//             '${title}',
//             style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: ScreenUtil().setSp(23)),
//           ),
//         ),
//         content: Container(
//           width: ScreenUtil().screenWidth,
//           color: Colors.white,
//           child: Column(
//             children: [
//               Column(
//                   // Text('${ModelListReminder.listReminder.values.elementAt(index)['${title}'][index1].title}');
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: List.generate(
//                       ModelListReminder.listReminder.values.length, (index) {
//                     return Column(
//                       children: List.generate(
//                           ModelListReminder.listReminder.values
//                                       .elementAt(index)['${title}'] ==
//                                   null
//                               ? 0
//                               : ModelListReminder.listReminder.values
//                                   .elementAt(index)['${title}']
//                                   .length, (index1) {
//                         List<Reminder> reminder = ModelListReminder
//                             .listReminder.values
//                             .elementAt(index)['${title}'];
//                         indexReminder = indexReminder + 1;
//                         return ListReminder(
//                           controller: controler,
//                           keyDate: keyDate,
//                           scheduleReminderBloc: scheduleReminderBloc,
//                           indexGroup: indexSticky,
//                           indexReminder: indexReminder,
//                           title: reminder[index1].title,
//                           note: reminder[index1].note,
//                           group: ModelListReminder
//                               .myList['${reminder[index1].group}'].title,
//                           date: reminder[index1].date,
//                           time: reminder[index1].time,
//                         );
//                       }),
//                     );
//                   })),
//               AddWidget(
//                 keyDate: title,
//                 scheduleReminderBloc: scheduleReminderBloc,
//                 index: indexSticky,
//                 controller: controler,
//               )
//             ],
//           ),
//         ));
//   }
// }
