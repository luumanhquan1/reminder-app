import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/common/constants/route_constants.dart';
import 'package:ghichu/common/locator/service_locator.dart';
import 'package:ghichu/presentation/journey/group/add_list/add_list_screen.dart';
import 'package:ghichu/presentation/journey/group/add_list/bloc/add_list_bloc.dart';

class RouteGroup {
  static Map<String, WidgetBuilder> getAll() {
    return {
      RouteList.addGroup: (context) =>
          BlocProvider(create: (context) => locator<AddListBloc>(),
            child: AddGroupScreen(),
          ),
    };
  }
}
