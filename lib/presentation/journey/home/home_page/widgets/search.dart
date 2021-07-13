import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/presentation/journey/group/add_list/add_list_constaner.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';

class SearchWidget extends StatelessWidget {
 final Function onTap;
 final InitHomePageState state;
  const SearchWidget({Key key, this.onTap,this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value){
              BlocProvider.of<HomePageBloc>(context).add(SearchReminderEvent(search: value));
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
                  BlocProvider.of<HomePageBloc>(context).add(SearchReminderEvent(isSearch: false));
                },
                child: Text('Hủy',style: TextStyle(color: Colors.blue,fontSize: ScreenUtil().setSp(18)),)),
          ),
        )
      ],
    );
  }
}
