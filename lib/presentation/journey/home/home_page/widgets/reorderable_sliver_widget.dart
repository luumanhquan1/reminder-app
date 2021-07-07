

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:reorderables/reorderables.dart';

import '../home_page_constants.dart';
import 'my_list_widget.dart';

// ignore: must_be_immutable
class ReorderableSliverWidget extends StatelessWidget {
  final InitHomePageState state;
  SlidableController slidableController;
  ScrollController scrollController;
  ReorderableSliverWidget(
      {Key key,
      @required this.state,
      this.slidableController,
      this.scrollController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.fromLTRB(HomePageConstants.paddingWidth20, 0,
            HomePageConstants.paddingWidth20, 0),
        sliver: ReorderableSliverList(
            enabled: state.isOpen,
            delegate: ReorderableSliverChildListDelegate(
                List.generate(state.keyMyList.length, (index) {
              return GestureDetector(
                onTap: (){
                  BlocProvider.of<HomePageBloc>(context).add(PushMyListEvent(groupEntity: state.keyMyList[index]));
                },
                child: MyListWidget(
                  slidableController: slidableController,
                  title: state.keyMyList[index].name,
                  index: index,
                  state: state,
                  leght: state.remindertoGroup[state.keyMyList[index].name],
                  color: state.keyMyList[index].color,
                ),
              );
            })),
            onReorder: (int oldIndex, int newIndex) {
              if (newIndex != oldIndex) {
                BlocProvider.of<HomePageBloc>(context).add(OrderGroupEvent(
                  oldIndex: oldIndex,
                  newIndex: newIndex,
                ));
              }
            }));
  }
}
