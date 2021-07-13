import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/presentation/journey/group/add_list/add_list_constaner.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/reminder/__mock__/textfiled_controller.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/blocs/manage_reminder_bloc/manage_reminder_event.dart';

class SearchWidget extends StatelessWidget {
 final Function onTap;
 final InitHomePageState state;
 final TextEditingController controller;
 FocusNode focusNode;
   SearchWidget({Key key, this.onTap,this.state,this.controller}) : super(key: key){
    focusNode=FocusNode();
   }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
           controller: controller,
            focusNode: focusNode,
            onChanged: (value){
              BlocProvider.of<HomePageBloc>(context).add(SearchReminderHomeEvent(value));
              if(value.isNotEmpty){
                BlocProvider.of<ManageReminderBloc>(context).add(SearchReminderEvent(value));
              }
            },
            onTap: onTap,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
              EdgeInsets.only(top: ScreenUtil().setHeight(13)),

              filled: true,
              border: InputBorder.none,
              hintText: 'Search',
              hintStyle: TextStyle(fontSize: ScreenUtil().setSp(15)),
              prefixIcon: Icon(Icons.search,size: ScreenUtil().setSp(20),),
              prefixIconConstraints: BoxConstraints(

                  minWidth: ScreenUtil().setWidth(40),
                  minHeight: ScreenUtil().setHeight(40)
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:  BorderSide(color: Colors.transparent),
                borderRadius: AddListConstants.radiusCircle10,
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide:  BorderSide(color: Colors.transparent),
                borderRadius: AddListConstants.radiusCircle10,
              ),
              // border: InputBorder.none,
            ),
          ),
        ),

        Visibility(
          visible: state.isSearch,
          child: Padding(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(10)),
            child: GestureDetector(
                onTap: (){
                  BlocProvider.of<HomePageBloc>(context).add(ActiveSearchReminderEvent(isSearch: false));
                  controller.text="";
                  focusNode.unfocus();
                },
                child: Text('Hủy',style: TextStyle(color: Colors.blue,fontSize: ScreenUtil().setSp(18)),)),
          ),
        )
      ],
    );
  }
}
