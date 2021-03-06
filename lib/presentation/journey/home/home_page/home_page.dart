import 'dart:developer';

import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ghichu/common/constants/route_constants.dart';
import 'package:ghichu/common/setting_argument/settting_argument.dart';
import 'package:ghichu/domain/entities/group_entity.dart';

import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:ghichu/presentation/journey/home/home_page/home_page_constants.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/bottom_navigationbar_widget.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/edit_home_page.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/reorderable_sliver_widget.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/search.dart';
import 'package:ghichu/presentation/journey/home/home_page/widgets/sliver_list_reminder_system.dart';
import 'package:ghichu/presentation/journey/home/search_screen/search_screent.dart';
import 'package:ghichu/presentation/journey/widgets/app_bar.dart';
import 'package:ghichu/presentation/journey/widgets/dia_log_widget.dart';
import 'package:ghichu/presentation/journey/widgets/show_toast_error.dart';
import 'package:ghichu/presentation/view_state.dart';

import 'bloc/home_page_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<HomePage> {
  SlidableController slidableController;
  ScrollController reorderController;
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    slidableController = SlidableController(
      onSlideAnimationChanged: handleSlideAnimationChanged,
      onSlideIsOpenChanged: handleSlideIsOpenChanged,
    );
    super.initState();
  }

  void handleSlideAnimationChanged(Animation<double> slideAnimation) {}

  void handleSlideIsOpenChanged(bool isOpen) {
    BlocProvider.of<HomePageBloc>(context)
        .add(SlideIsOpenEvent(isOpen: !isOpen));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {
        if (state is InitHomePageState) {
          if (state.viewState == ViewState.showDiglog) {
            showDialog(
                context: context,
                builder: (_) => DiaLogWidget(
                      name: state.keyMyList[state.index].name,
                    )).then((value) {
              if (value != null) {
                BlocProvider.of<HomePageBloc>(context)
                    .add(DeleteGroupEvent(isDialog: true, index: state.index));
              }
            });
          }
          if (state.viewState == ViewState.error) {
            showError();
          }
        }
        if (state is EditGroupState) {
          Navigator.pushNamed(context, RouteList.addGroup,
                  arguments: SettingEditGroup(state.index, state.groupEntity))
              .then((value) {
            if (value != null) {
              BlocProvider.of<HomePageBloc>(context)
                  .add(UpdateEditGroupEvent());
            }
          });
        }
        if (state is PushMyListState) {
          Navigator.pushNamed(context, RouteList.todayPage,
                  arguments: SettingReminder(
                      groupEntity: state.groupEntity,
                      listGroup: state.listGroup))
              .then((value) {
            if (value == true) {
              BlocProvider.of<HomePageBloc>(context).add(UpDateReminderEvent());
            }
          });
        }
        if (state is PushAddGroupState) {
          Navigator.pushNamed(context, RouteList.addGroup).then((value) {
            if (value != null) {
              BlocProvider.of<HomePageBloc>(context).add(UpDateGroupEvent());
            }
          });
        }
        if (state is PushNewReminderState) {
          Navigator.pushNamed(context, RouteList.newReminder,
                  arguments: SettingNewReminder(
                      listGroup: state.listGroup, isEditReminder: false))
              .then((value) {
            if (value != null) {
              BlocProvider.of<HomePageBloc>(context).add(UpDateReminderEvent());
            }
          });
        }
        if(state is PushReminderSystemState){
          Navigator.pushNamed(context, state.routeName,
              arguments: SettingReminder(listGroup: state.listGroup))
              .then((value) {
            if (value == true) {
              BlocProvider.of<HomePageBloc>(context).add(UpDateReminderEvent());
            }
          });
        }
      },
      builder: (context, state) {
        if (state is InitHomePageState) {
          return Scaffold(
            backgroundColor: Colors.white.withOpacity(0.95),
            appBar: AppBarWidget(
              heightAppbar: state.isSearch ? 2 : 64,
              textLeft: '',
              title: '',
              textRight: state.isEdit && state.isOpen
                  ? HomePageConstants.editTxt
                  : HomePageConstants.doneTxt,
              color: Colors.blue,
              actions: () {
                BlocProvider.of<HomePageBloc>(context)
                    .add(EditEvent(isEdit: state.isEdit));
              },
            ),
            body: homePage(state),
            bottomNavigationBar: state.isSearch
                ? SizedBox()
                : BottomNavigationBarWidget(state: state),
          );
        }

        return SizedBox();
      },
    );
  }

  Widget homePage(InitHomePageState state) {
    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(HomePageConstants.paddingWidth20,
                    0, HomePageConstants.paddingWidth20, 0),
                child: state.isSearch
                    ? SizedBox(
                        height: ScreenUtil().setHeight(40),
                      )
                    : SearchWidget(
                        controller: searchController,
                        onTap: () {
                          BlocProvider.of<HomePageBloc>(context)
                              .add(ActiveSearchReminderEvent(isSearch: true));
                        },
                        state: state,
                      ),
              ),
            ),
            SliverReminderWidget(
              state: state,
            ),
            ReorderableSliverWidget(
              scrollController: reorderController,
              slidableController: slidableController,
              state: state,
            )
          ],
        ),
        Visibility(visible: state.isSearch, child: searchWidget(state))
      ],
    );
  }

  Widget searchWidget(InitHomePageState state) {
    return SearchScreen(slidableController: slidableController,searchController: searchController,state: state,);
  }
}
