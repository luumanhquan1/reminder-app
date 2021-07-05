import 'package:flutter/material.dart';
import 'package:ghichu/common/constants/route_constants.dart';

import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/home/home_page/home_page_constants.dart';

import 'package:ghichu/presentation/journey/home/home_page/widgets/sight_widget.dart';

class WrapWidget extends StatelessWidget {
  InitHomePageState state;
  WrapWidget({Key key, this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: state.isEdit,
      maintainAnimation: true,
      maintainState: true,
      child: AnimatedOpacity(
          opacity: !state.isEdit ? 0 : 1,
          duration: HomePageConstants.durationContainer,
          child: Wrap(
              spacing: HomePageConstants.paddingWidth20,
              children: List.generate(state.reminderSystem.length, (index) {
                // return SightWidget(index: index);
                if (state.reminderSystem[index] == 'Today') {
                  return SightWidget(
                    routeName: RouteList.todayPage,
                      index: index,
                      reminderColor: HomePageConstants.reminderTodayColor,
                      reminderIcon: HomePageConstants.reminderTodayIcon,
                      reminderTxt: HomePageConstants.reminderTodayTxt,
                      reminderLeght: state.reminderToday);
                }
                if (state.reminderSystem[index] == 'Scheduled') {
                  return SightWidget(
                      routeName: RouteList.scheduled,
                      index: index,
                      reminderColor: HomePageConstants.reminderScheduledColor,
                      reminderIcon: HomePageConstants.reminderScheduledIcon,
                      reminderTxt: HomePageConstants.reminderScheduledTxt,
                      reminderLeght: state.reminderScheduled);
                }
                if (state.reminderSystem[index] == 'All') {
                  return SightWidget(
                      routeName: RouteList.allPage,
                      index: index,
                      reminderColor: HomePageConstants.reminderAllColor,
                      reminderIcon: HomePageConstants.reminderAllIcon,
                      reminderTxt: HomePageConstants.reminderAllTxt,
                      reminderLeght: state.reminderAll,
                       listGroup: state.keyMyList,
                  );
                }
                return SizedBox();
              }))),
    );
  }
}
