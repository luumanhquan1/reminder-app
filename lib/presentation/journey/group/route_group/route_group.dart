import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/common/constants/route_constants.dart';
import 'package:ghichu/common/locator/service_locator.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';

import 'package:ghichu/presentation/journey/group/add_list/add_list_screen.dart';
import 'package:ghichu/presentation/journey/group/add_list/bloc/add_list_bloc.dart';
import 'package:ghichu/presentation/journey/group/add_list/bloc/add_list_event.dart';

class RouteGroup {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.addGroup: (context) {
        SettingEditGroup result = ModalRoute.of(context).settings.arguments;
        if (result == null) {
          return BlocProvider(
            create: (context) => locator<AddListBloc>(),
            child: AddGroupScreen(),
          );
        }
        return BlocProvider(
          create: (context) => locator<AddListBloc>()
            ..add(UpDateEditGroupEvent(result.groupEntity)),
          child: AddGroupScreen(
            index: result.index,
            groupEntity: result.groupEntity,
          ),
        );
      }
    };
  }
}
