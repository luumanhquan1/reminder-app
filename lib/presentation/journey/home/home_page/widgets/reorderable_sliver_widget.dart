import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_bloc.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_event.dart';
import 'package:ghichu/presentation/journey/home/home_page/bloc/home_page_state.dart';
import 'package:reorderables/reorderables.dart';

import '../home_page_constants.dart';
import 'my_list_widget.dart';
class ReorderableSliverWidget extends StatelessWidget {
 final HomePageState state;

  const ReorderableSliverWidget({Key key,@required this.state}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
        padding: EdgeInsets.fromLTRB(
            HomePageConstants.paddingWidth20,
            0,
            HomePageConstants.paddingWidth20,
            0),
        sliver: ReorderableSliverList(
            delegate: ReorderableSliverChildListDelegate(
                List.generate(state.keyMyList.length, (index) {
                  return MyListWidget(
                    title: state.keyMyList[index].name,
                    index: index,
                    state: state,
                    leght: state
                        .remindertoGroup[state.keyMyList[index].name]
                        .length,
                    color: state.keyMyList[index].color,
                  );
                })),
            onReorder: (int oldIndex, int newIndex) {
              if (newIndex != oldIndex) {
                BlocProvider.of<HomePageBloc>(context)
                    .add(OrderGroupEvent(
                  oldIndex: oldIndex,
                  newIndex: newIndex,
                ));
              }
            }));
  }
}
