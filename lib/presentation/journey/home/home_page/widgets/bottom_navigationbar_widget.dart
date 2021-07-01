import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/common/constants/route_constants.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/widgets/bottom_new_reminder.dart';

import '../home_page_constants.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final InitHomePageState state;

  const BottomNavigationBarWidget({Key key, @required this.state})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(HomePageConstants.paddingWidth15, 0,
          HomePageConstants.paddingWidth15, HomePageConstants.paddingHeight20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              margin: EdgeInsets.only(top: HomePageConstants.paddingHeight10),
              child: BottomNewReminder(
                onTap: () {
                  Navigator.pushNamed(context, RouteList.newReminder,
                          arguments: SettingNewReminder(
                              listGroup: state.keyMyList,
                              isEditReminder: false))
                      .whenComplete(() {
                    BlocProvider.of<HomePageBloc>(context)
                        .add(UpDateReminderEvent());
                  });
                },
              )),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RouteList.addGroup).then((value) {
                if (value != null) {
                  BlocProvider.of<HomePageBloc>(context)
                      .add(UpDateGroupEvent());
                }
              });
            },
            child: Text(
              HomePageConstants.addListTxt,
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: HomePageConstants.screenUtileSp18),
            ),
          )
        ],
      ),
    );
  }
}
