import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:ghichu/presentation/view_state.dart';

abstract class AddListState extends Equatable {}

// ignore: must_be_immutable
class InitialAddListState extends AddListState {
  final String name;
  final Color color;
  final bool activeAddBtn;
  final int index;
  ViewState viewState;
  InitialAddListState(
      {this.name,
      @required this.color,
      this.activeAddBtn,
      this.index,
      this.viewState});

  InitialAddListState update(
          {Color selectColor,
          String name,
          bool activeAddBtn,
          int index,
          ViewState viewState}) =>
      InitialAddListState(
          name: name ?? this.name,
          viewState: viewState ?? this.viewState,
          color: selectColor ?? this.color,
          activeAddBtn: activeAddBtn ?? this.activeAddBtn,
          index: index ?? this.index);

  @override
  List<Object> get props => [
        this.viewState,
        this.name,
        this.color,
        this.index,
        this.activeAddBtn,
      ];
}

class PopAddListGroupState extends AddListState {
  @override
  final bool isRemove;

  PopAddListGroupState({this.isRemove});
  List<Object> get props => [this.isRemove];
}
