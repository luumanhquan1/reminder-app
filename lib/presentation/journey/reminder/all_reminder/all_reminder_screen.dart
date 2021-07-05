
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';

import 'package:ghichu/data/models/model_map.dart';
import 'package:ghichu/domain/entities/group_entity.dart';

import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
import 'package:ghichu/presentation/journey/reminder/all_reminder/all_reminder_constants.dart';
import 'package:ghichu/presentation/journey/reminder/all_reminder/bloc/all_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/all_reminder/bloc/all_reminder_state.dart';
import 'package:ghichu/presentation/journey/reminder/all_reminder/widgets/sticky_header_widget.dart';
import 'package:ghichu/presentation/journey/reminder/widgets/app_bar_reminder.dart';

class AllPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<AllPage> {
  Map<String, TextFiledController> listController = {};
  // AllReminderBloc allReminderBloc = AllReminderBloc();

  bool isEdit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (int i = 0; i < ModelListReminder.myList.length; i++) {
      listController.addAll({
        '$i': TextFiledController(
            textEditingController: TextEditingController(),
            focusNode: FocusNode())
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AllReminderBloc, AllReminderState>(
      listener: (context,state){

      },
      builder: (context, state) {
        if(state is InitAllReminderState){
          return  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarReminderWidget(
              isIconEdit: false,
              actions: true
                  ? () {
                // reminderUntil(
                //     type: ReminderEnum.All,
                //     allReminderBloc: allReminderBloc,
                //     controller: listController,
                //     keyGroup: snapshot.data.group);
                // allReminderBloc.allReminderState.indexGroup = null;
                // allReminderBloc.allReminderState.indexGroupReminder =
                // null;
                // allReminderBloc.update();
              }
                  : null,
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
                    children: List.generate(state.listReminder.length,
                            (index) {
                      GroupEntity listGroup=state.listGroup[index];
                          return StickyReminderAll(
                            listReminder: state.listReminder[listGroup.name],
                            header: listGroup.name,
                            color: listGroup.color,
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
}
