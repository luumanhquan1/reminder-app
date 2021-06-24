import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/common/constants/route_constants.dart';

import 'package:ghichu/common/locator/service_locator.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';

import 'package:ghichu/presentation/journey/reminder/all_reminder/all_reminder_screen.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/bloc/details_event.dart';

import 'package:ghichu/presentation/journey/reminder/create_reminder/details_screen/details_screen.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/list_group/bloc/list_group_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/list_group/bloc/list_group_event.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/list_group/list_group.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/new_reminder/bloc/new_reminder_bloc.dart';

import 'package:ghichu/presentation/journey/reminder/create_reminder/new_reminder/new_reminder.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/priorities_screen/bloc/priority_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/priorities_screen/bloc/priority_event.dart';

import 'package:ghichu/presentation/journey/reminder/create_reminder/priorities_screen/priorities_screen.dart';

import 'package:ghichu/presentation/journey/reminder/schedule_reminder/schedule_reminder_screen.dart';
import 'package:ghichu/presentation/journey/reminder/today_reminder/today_reminder_screen.dart';

import 'create_reminder/new_reminder/bloc/new_reminder_event.dart';

class RouteReminder {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.allPage: (context) => AllPage(),
      RouteList.scheduled: (context) => SchedulePage(),
    };
  }

  static Map<String, WidgetBuilder> getRoutesWithSettings(
      RouteSettings settings) {
    final args = settings.arguments;
    return {
      RouteList.todayPage: (context) {
        // var keyGroup = args[StringConstants.keyGroup];
        return TodayPage(
            // keyGroup: keyGroup,
            );
      },
      RouteList.prioritiesScreen: (context) {
        SettingPriority setting = args;
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => PriorityBloc()
                ..add(SelectPriortyEvent(indexSelect: setting.indexSelect))),
        ], child: PrioritiesScreen());
      },
      RouteList.details: (context) {
        SettingDetails settingDetails = args;
        return MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (context) => locator<DetailsBloc>()
                  ..add(UpDateStateDetailsEvent(state: settingDetails.state)))
          ],
          child: DetailsPage(
            settingDetails: settingDetails,
          ),
        );
      },
      RouteList.newReminder: (context) {
        SettingNewReminder settingNewReminder = args;
        return MultiBlocProvider(
            providers: [
              BlocProvider<NewReminderBloc>(
                  create: (context) => locator<NewReminderBloc>()
                    ..add(UpDateNewReminderListGroupEvent(
                        groups: settingNewReminder.listGroup[0]))),
            ],
            child: NewReminderPage(
              settingNewReminder: settingNewReminder,
            ));
      },
      RouteList.listGroup: (context) {
        SettingListGroup settingListGroup = args;
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => ListGroupBloc()
                    ..add(SelectGroupEvent(settingListGroup.listGroup
                        .indexOf(settingListGroup.group)))),
            ],
            child: ListGroupScreen(
              settingListGroup: settingListGroup,
            ));
      }
    };
  }
}
