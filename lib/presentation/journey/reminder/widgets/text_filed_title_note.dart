import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/presentation/journey/reminder/reminder_constants.dart';
// ignore: must_be_immutable
class TitleNoteWidget extends StatelessWidget {
  TextEditingController titleController;
  TextEditingController noteController;
  Function onChange;
  TitleNoteWidget(
      {Key key, this.onChange, this.titleController, this.noteController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
      width: double.infinity,
      height: ScreenUtil().setHeight(150),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Container(
            height: ScreenUtil().setHeight(45),
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black, width: 0.2))),
            child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Title',
                    hintStyle:
                        TextStyle(fontSize: ReminderContants.fontHineText)),
                onChanged: onChange),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(5),
          ),
          Expanded(
            child: ListView(
              children: [
                TextField(
                  controller: noteController,
                  maxLines: null,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Notes',
                      hintStyle:
                          TextStyle(fontSize: ReminderContants.fontHineText)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
