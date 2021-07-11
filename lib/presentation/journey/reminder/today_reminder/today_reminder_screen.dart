import 'dart:developer';

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ghichu/common/constants/route_constants.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/domain/entities/reminder_entity.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_event.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';
import 'package:ghichu/presentation/journey/reminder/reminder_constants.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/app_bar_reminder.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/list_reminder.dart';

// ignore: must_be_immutable
class TodayPage extends StatefulWidget {
  final GroupEntity groupEntity;

  TodayPage({this.groupEntity});

  @override
  _State createState() => _State();
}

class _State extends State<TodayPage> {
  SlidableController slidableController;
  @override
  void initState() {
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
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
      listener: (context, state) {
        if (state is EditReminderState) {
          Navigator.pushNamed(context, RouteList.newReminder,
                  arguments: SettingNewReminder(
                      reminderEntity: state.reminderEntity,
                      isEditReminder: true,
                      listGroup: state.listGroup,
                      groupEntityl: state.groupEntity))
              .then((value) {
            if (value != null) {
              if (widget.groupEntity == null) {
                BlocProvider.of<ManageReminderBloc>(context)
                    .add(GetDateToDayEvent(listGroup: state.listGroup));
              } else {
                BlocProvider.of<ManageReminderBloc>(context).add(
                    GetDateGroupEvent(
                        listGroup: state.listGroup,
                        groupEntity: widget.groupEntity));
              }
            }
          });
        }
      },
      builder: (context, state) {
        if (state is InitManagerReminderState) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarReminderWidget(
              isIconEdit: isEditIcon(state),
              actions: isEditIcon(state)
                  ? () {
                      // todayReminderBloc.todayReminderState.indexReminder = null;
                      // todayReminderBloc.update();
                    }
                  : null,
              leading: () {
                Navigator.pop(context, state.isChangeState);
              },
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
                    child: Text(
                      widget.groupEntity == null
                          ? 'Hôm nay'
                          : widget.groupEntity.name,
                      style: TextStyle(
                          color: widget.groupEntity == null
                              ? Colors.blue
                              : Color(int.parse(widget.groupEntity.color)),
                          fontWeight: FontWeight.w800,
                          fontSize: ScreenUtil().setSp(30)),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  state.reminderGroupOrToday.length == 0
                      ? Center(
                          heightFactor: ScreenUtil().setHeight(30),
                          child: Text(
                            ReminderContants.emptyTxt,
                            style: ReminderContants.textStyleEmpty,
                          ),
                        )
                      : Column(
                          children: List.generate(
                              state.reminderGroupOrToday.length, (index) {
                            ReminderEntity reminder =
                                state.reminderGroupOrToday[index];
                            if (widget.groupEntity == null) {
                              return ListReminder(
                                selectReminder: () {
                                  BlocProvider.of<ManageReminderBloc>(context)
                                      .add(SelectReminderEvent(
                                          indexReminder: index, indexGroup: 0));
                                },
                                state: state,
                                indexReminder: index,
                                indexGroup: 0,
                                editReminderBtn: () {
                                  BlocProvider.of<ManageReminderBloc>(context)
                                      .add(EditReminderEvent(
                                          group: reminder.list,
                                          reminderEntity: reminder));
                                },
                                deleleReminderBtn: () {
                                  BlocProvider.of<ManageReminderBloc>(context)
                                      .add(DeleteReminderEvent(
                                          reminderEntity: reminder,
                                          index: index));
                                },
                                slidableController: slidableController,
                                title: reminder.title,
                                note: reminder.note,
                                group: reminder.list,
                                time: reminder.details.time ?? '',
                              );
                            }
                            return ListReminder(
                              editReminderBtn: () {
                                BlocProvider.of<ManageReminderBloc>(context)
                                    .add(EditReminderEvent(
                                        group: widget.groupEntity.name,
                                        reminderEntity: reminder));
                              },
                              deleleReminderBtn: () {
                                BlocProvider.of<ManageReminderBloc>(context)
                                    .add(DeleteReminderEvent(
                                        reminderEntity: reminder,
                                        index: index));
                              },
                              selectReminder: () {
                                BlocProvider.of<ManageReminderBloc>(context)
                                    .add(SelectReminderEvent(
                                        indexReminder: index, indexGroup: 0));
                              },
                              state: state,
                              indexReminder: index,
                              indexGroup: 0,
                              slidableController: slidableController,
                              title: reminder.title,
                              note: reminder.note,
                              date: reminder.details.date ?? '',
                              time: reminder.details.time ?? '',
                            );
                          }),
                        )
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }
  bool isEditIcon(InitManagerReminderState state){
    if(state.indexReminder!=-1||state.indexGroup!=-1){
      return true;
    }
    return false;
  }
}
