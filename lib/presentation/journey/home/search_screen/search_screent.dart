import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ghichu/common/constants/route_constants.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';
import 'package:ghichu/domain/entities/group_entity.dart';
import 'package:ghichu/presentation/journey/blocs/manage_reminder_bloc/manage_reminder_bloc.dart';
import 'package:ghichu/presentation/journey/blocs/manage_reminder_bloc/manage_reminder_event.dart';
import 'package:ghichu/presentation/journey/blocs/manage_reminder_bloc/manage_reminder_state.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/home/home_page/home_page_constants.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/search.dart';
import 'package:ghichu/presentation/journey/reminder/all_reminder/widgets/sticky_header_widget.dart';

class SearchScreen extends StatelessWidget {
  final InitHomePageState state;
  final TextEditingController searchController;
  final SlidableController slidableController;
  const SearchScreen(
      {Key key, this.state, this.searchController, this.slidableController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(HomePageConstants.paddingWidth20, 0,
                  HomePageConstants.paddingWidth20, 0),
              child: SearchWidget(
                controller: searchController,
                onTap: () {
                  BlocProvider.of<HomePageBloc>(context)
                      .add(ActiveSearchReminderEvent(isSearch: true));
                },
                state: state,
              ),
            ),
            BlocConsumer<ManageReminderBloc, ManageReminderState>(
                listener: (context, stateReminder) {
              if (stateReminder is EditReminderState) {
                Navigator.pushNamed(context, RouteList.newReminder,
                        arguments: SettingNewReminder(
                            reminderEntity: stateReminder.reminderEntity,
                            isEditReminder: true,
                            listGroup: stateReminder.listGroup,
                            groupEntityl: stateReminder.groupEntity))
                    .then((value) {
                  if (value != null) {
                    BlocProvider.of<ManageReminderBloc>(context).add(SearchReminderEvent(search: searchController.text));
                    BlocProvider.of<HomePageBloc>(context).add(UpDateReminderEvent());
                  }
                });
              }
            }, builder: (context, stateReminder) {
              if (stateReminder is InitManagerReminderState) {
                return Column(
                  children:
                      List.generate(stateReminder.listReminder.length, (index) {
                    String header =
                        stateReminder.listReminder.keys.elementAt(index);
                    GroupEntity groupEntity = state.keyMyList
                        .where((element) => element.name == header)
                        .elementAt(0);
                    return StickyReminderAll(
                      isSearch: true,
                      state: stateReminder,
                      groupEntity: groupEntity,
                      listGroup: state.keyMyList,
                      slidableController: slidableController,
                      indexGroup: index,
                      listReminder: stateReminder.listReminder[header],
                      header: groupEntity.name,
                      color: groupEntity.color,
                    );
                  }),
                );
              }
              return SizedBox();
            }),
            BlocBuilder<ManageReminderBloc, ManageReminderState>(
                builder: (context, stateReminder) {
              return GestureDetector(
                onTap: searchController.text.trim().isEmpty
                    ? () {
                        BlocProvider.of<HomePageBloc>(context)
                            .add(ActiveSearchReminderEvent(isSearch: false));
                        BlocProvider.of<ManageReminderBloc>(context)
                            .add(SearchReminderEvent(search: ''));
                        searchController.text = "";
                        // focusNode.unfocus();
                      }
                    : null,
                child: Container(
                  constraints:
                      BoxConstraints(minHeight: ScreenUtil().screenHeight),
                  width: double.infinity,
                  color: searchController.text.trim().isNotEmpty
                      ? Colors.white
                      : Colors.transparent,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
