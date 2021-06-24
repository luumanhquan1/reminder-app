import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:ghichu/presentation/journey/group/add_list/bloc/add_list_bloc.dart';
import 'package:ghichu/presentation/journey/group/add_list/bloc/add_list_event.dart';
import 'package:ghichu/presentation/journey/group/add_list/bloc/add_list_state.dart';

import '../add_list_constaner.dart';

class SelectColors extends StatelessWidget {
  InitialAddListState addListState;

  SelectColors({Key key, this.addListState}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(AddListConstants.listColors.length, (index) {
        return GestureDetector(
            onTap: () {
              BlocProvider.of<AddListBloc>(context).add(
                SelectColorEvent(
                    color: AddListConstants.listColors[index],
                    indexSelect: index),
              );
              // addListBloc.setColor(index, AddListConstants.listColors[index]);
            },
            child: Container(
              margin: EdgeInsets.only(
                  left: AddListConstants.paddingWith,
                  top: AddListConstants.paddingHeight10),
              height: AddListConstants.sizeContainerColor,
              width: AddListConstants.sizeContainerColor,
              padding: EdgeInsets.all(ScreenUtil().setSp(3)),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: index == addListState.index
                          ? Colors.black45
                          : Colors.transparent,
                      width: 2),
                  shape: BoxShape.circle),
              child: Container(
                height: AddListConstants.sizeContainerColor,
                width: AddListConstants.sizeContainerColor,
                decoration: BoxDecoration(
                    color: AddListConstants.listColors[index],
                    shape: BoxShape.circle),
              ),
            ));
      }),
    );
  }
}
