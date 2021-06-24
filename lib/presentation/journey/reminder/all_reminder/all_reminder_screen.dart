import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/common/enums/reminder_enum.dart';
import 'package:ghichu/common/untils/reminder_until.dart';
import 'package:ghichu/data/models/model_map.dart';

import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
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
  AllReminderBloc allReminderBloc = AllReminderBloc();

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
    return StreamBuilder<AllReminderState>(
        initialData: allReminderBloc.allReminderState,
        stream: allReminderBloc.allController,
        builder: (context, snapshot) {
          if (snapshot.data.indexGroupReminder != null) {
            isEdit = true;
          } else if (snapshot.data.indexGroup == null) {
            isEdit = false;
          } else {
            isEdit = true;
          }

          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBarReminderWidget(
              isIconEdit: isEdit,
              actions: isEdit
                  ? () {
                      reminderUntil(
                          type: ReminderEnum.All,
                          allReminderBloc: allReminderBloc,
                          controller: listController,
                          keyGroup: snapshot.data.group);
                      allReminderBloc.allReminderState.indexGroup = null;
                      allReminderBloc.allReminderState.indexGroupReminder =
                          null;
                      allReminderBloc.update();
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
                      'All',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w900,
                          fontSize: ScreenUtil().setSp(30)),
                    ),
                  ),
                  Column(
                    children: List.generate(
                        ModelListReminder.listReminder.length, (index) {
                      int indexReminder = 0;
                      String keyGroup = ModelListReminder.myList.keys
                          .toList()
                          .elementAt(index);
                      return StickyReminderAll(
                        keyGroup: snapshot.data.group,
                        allReminderBloc: allReminderBloc,
                        indexReminder: indexReminder,
                        controller: listController,
                        indexHeader: index,
                        header: keyGroup,
                        color: ModelListReminder.myList['$keyGroup'].color,
                        listReminderAll:
                            ModelListReminder.listReminder['$keyGroup'],
                      );
                    }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    allReminderBloc.dispose();
    super.dispose();
  }
}
