
import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghichu/common/enums/reminder_enum.dart';
import 'package:ghichu/common/untils/reminder_until.dart';
import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_state.dart';

import '../reminder_constants.dart';

class AddWidget extends StatelessWidget {
  String keyGroup, keyDate;
  TextEditingController controller;
  FocusNode focusNode;
  int index;
  InitManagerReminderState state;
  Function onTap;
  AddWidget(
      {Key key,
      this.keyGroup,
      this.keyDate,
      this.index,
        this.onTap,
      @required this.state}): super(key: key){
    controller=TextEditingController();
    focusNode=FocusNode();
  }
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      onTap:onTap,
      style: TextStyle(fontSize: ScreenUtil().setSp(16)),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 1.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 1.5),
        ),
        suffixIcon: Visibility(
            visible: index == state.indexGroup &&state.indexReminder==-1? true : false,
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.error_outline,
                size: ScreenUtil().setSp(23),
                color: ReminderContants.colorIcon,
              ),
            )),
        prefixIcon: Icon(
          Icons.add_circle_outlined,
          size: ScreenUtil().setSp(25),
          color: Colors.black45,
        ),
        // helperText: scheduleReminderBloc != null ? "Reminder" : '',
        helperStyle:
            TextStyle(color: Colors.black45, fontSize: ScreenUtil().setSp(13)),
      ),
    );
  }
}
