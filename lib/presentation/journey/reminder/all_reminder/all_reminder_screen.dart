import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ghichu/common/constants/route_constants.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';

import 'package:ghichu/data/models/model_map.dart';
import 'package:ghichu/domain/entities/group_entity.dart';

import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
import 'package:ghichu/presentation/journey/reminder/all_reminder/all_reminder_constants.dart';

import 'package:ghichu/presentation/journey/reminder/all_reminder/widgets/sticky_header_widget.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_event.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/app_bar_reminder.dart';

class AllPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AllPage> {
  Map<String, TextFiledController> listController = {};
  bool isEdit;
  SlidableController slidableController;
  @override
  void initState() {
    // TODO: implement initState
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    super.initState();
    BlocProvider.of<ManageReminderBloc>(context)
        .add(AddControllerTextFieldEvent());
  }

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {}
  void handleSlideIsOpenChanged(bool isOpen) {
    if (isOpen) {
      BlocProvider.of<ManageReminderBloc>(context)
          .add(SelectReminderEvent(indexReminder: -1, indexGroup: -1));
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
              BlocProvider.of<ManageReminderBloc>(context)
                  .add(GetDataReminderAllEvent(listGroup: state.listGroup));
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
                      BlocProvider.of<ManageReminderBloc>(context).add(
                          SelectReminderEvent(
                              indexGroup: -1, indexReminder: -1));
                      BlocProvider.of<ManageReminderBloc>(context).add(AddReminderEvent());
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
                      AllReminderConstains.allTxt,
                      style: AllReminderConstains.allStyle,
                    ),
                  ),
                  Column(
                    children: List.generate(state.listReminder.length, (index) {
                      GroupEntity groupEntity = state.listGroup[index];
                      return StickyReminderAll(
                        isSearch: false,
                        state: state,
                        groupEntity: groupEntity,
                        listGroup: state.listGroup,
                        slidableController: slidableController,
                        indexGroup: index,
                        listReminder: state.listReminder[groupEntity.name],
                        header: groupEntity.name,
                        color: groupEntity.color,
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  bool isEditIcon(InitManagerReminderState state) {
    if (state.indexReminder != -1 || state.indexGroup != -1) {
      return true;
    }
    return false;
  }
}
