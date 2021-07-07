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

import 'blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'blocs/manage_reminder_bloc/manage_reminder_event.dart';
import 'create_reminder/new_reminder/bloc/new_reminder_event.dart';

class RouteReminder {
  static Map<String, WidgetBuilder> getRoutesWithSettings(
      RouteSettings settings) {
    final args = settings.arguments;
    return {
      RouteList.scheduled: (context) {
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) =>
                  locator<ManageReminderBloc>()..add(GetDataScheduledEvent()))
        ], child: SchedulePage());
      },
      RouteList.allPage: (context) {
        SettingAllReminder settingAll = args;
        return MultiBlocProvider(providers: [
          BlocProvider(
              create: (context) => locator<ManageReminderBloc>()
                ..add(GetDataReminderAllEvent(listGroup: settingAll.listGroup)))
        ], child: AllPage());
      },
      RouteList.todayPage: (context) {
        SettingToDay settingToday = args;
        if (settingToday == null) {
          return MultiBlocProvider(providers: [
            BlocProvider(
                create: (context) =>
                    locator<ManageReminderBloc>()..add(GetDateToDayEvent()))
          ], child: TodayPage());
        }
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      locator<ManageReminderBloc>()..add(GetDateGroupEvent(groupEntity: settingToday.groupEntity)))
            ],
            child: TodayPage(
              groupEntity: settingToday.groupEntity,
            ));
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
