
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/common/constants/route_constants.dart';
import 'package:ghichu/common/locator/service_locator.dart';
import 'package:ghichu/presentation/journey/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/home_page.dart';

class RouteHome{
  static Map<String,WidgetBuilder> getAll(){
    return {
      RouteList.homePage:(context)=>MultiBlocProvider(
      providers: [
        BlocProvider<HomePageBloc>(create: (context)=>locator<HomePageBloc>()..add(UpDate()),
        ),
        BlocProvider<ManageReminderBloc>(create: (context)=>locator<ManageReminderBloc>())
      ],
        child: HomePage(),
      ),
    };
  }
}