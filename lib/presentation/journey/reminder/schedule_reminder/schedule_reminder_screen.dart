
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ghichu/common/constants/route_constants.dart';
import 'package:ghichu/common/enums/reminder_enum.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';
import 'package:ghichu/common/untils/reminder_until.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_event.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';

import 'package:ghichu/presentation/journey/reminder/schedule_reminder/widgets/sticky_header_widget.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/app_bar_reminder.dart';

class SchedulePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SchedulePage> {
  SlidableController slidableController;
  @override
  void initState() {
    slidableController=SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    BlocProvider.of<ManageReminderBloc>(context).add(AddControllerTextFieldEvent());
    super.initState();
  }
  void handleSlideAnimationChanged(Animation<double> slideAnimation) {}
  void handleSlideIsOpenChanged(bool isOpen) {
    if(isOpen){
      BlocProvider.of<ManageReminderBloc>(context).add(SelectReminderEvent(indexReminder: -1,indexGroup: -1));
    }
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageReminderBloc, ManageReminderState>(
      listener: (context,state){
        if (state is EditReminderState) {
          Navigator.pushNamed(context, RouteList.newReminder,
              arguments: SettingNewReminder(
                  reminderEntity: state.reminderEntity,
                  isEditReminder: true,
                  listGroup: state.listGroup,
                  groupEntityl: state.groupEntity)).then((value) {
            if(value!=null){
              BlocProvider.of<ManageReminderBloc>(context).add(GetDataScheduledEvent(listGroup: state.listGroup));
            }
          });
        }
      },
        builder: (context, state) {
     if(state is InitManagerReminderState){
       return Scaffold(
         backgroundColor: Colors.white,
         appBar: AppBarReminderWidget(
           isIconEdit: isEditIcon(state),
           actions: isEditIcon(state)
               ? () {
             BlocProvider.of<ManageReminderBloc>(context).add(SelectReminderEvent(indexGroup: -1,indexReminder: -1));
           }
               : null,
           leading: (){
             Navigator.pop(context,state.isChangeState);
           },
         ),
         body: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Padding(
                 padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                 child: Text(
                   'Schedule',
                   style: TextStyle(
                       color: Colors.red,
                       fontWeight: FontWeight.w900,
                       fontSize: ScreenUtil().setSp(30)),
                 ),
               ),
               Column(
                 children: List.generate(state.listReminder.length, (index) {
                   String date=state.listReminder.keys.elementAt(index);
                   return StickyReminderSchedule(
                     state: state,
                    indexGroup: index,
                     slidableController: slidableController,
                     header: date,
                     color: Colors.black.value.toString(),
                     listReminder: state.listReminder[date],
                   );
                 }),
               )
             ],
           ),
         ),
       );
     }
     return SizedBox();
    });
  }
  bool isEditIcon(InitManagerReminderState state){
    if(state.indexReminder!=-1||state.indexGroup!=-1){
      return true;
    }
    return false;
  }
}
