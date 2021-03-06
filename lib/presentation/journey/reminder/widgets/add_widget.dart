
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ghichu/presentation/journey/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/blocs/manage_reminder_bloc/manage_reminder_event.dart';
import 'package:ghichu/presentation/journey/blocs/manage_reminder_bloc/manage_reminder_state.dart';

import '../reminder_constants.dart';

class AddWidget extends StatelessWidget {
  String keyGroup, keyDate,helperText;
  int index;
  InitManagerReminderState state;
  Function onTap;
  Function editReminerBtn;
  AddWidget(
      {Key key,
      this.keyGroup,
      this.keyDate,
      this.index,
      this.onTap,
        this.helperText,
        this.editReminerBtn,
      @required this.state})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

    return TextField(
      controller: state.listController["$index"].textEditingController,
      focusNode: state.listController["$index"].focusNode,
      onTap: () {
        BlocProvider.of<ManageReminderBloc>(context)
            .add(SelectReminderEvent(indexGroup: index, indexReminder: -1));
        BlocProvider.of<ManageReminderBloc>(context).add(AddReminderEvent());
      },
      style: TextStyle(fontSize: ScreenUtil().setSp(16)),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 1.5),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black45, width: 1.5),
        ),
        prefixIcon: Icon(
          Icons.add_circle_outlined,
          size: ScreenUtil().setSp(25),
          color: Colors.black45,
        ),
        helperText: helperText != null ? "          $helperText" : '',
        helperStyle:
            TextStyle(color: Colors.black45, fontSize: ScreenUtil().setSp(13)),
      ),
    );
  }
}
