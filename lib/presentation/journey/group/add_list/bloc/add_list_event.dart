import 'dart:ui';

import 'package:flutter/cupertino.dart';


abstract class AddListEvent {}

class SelectColorEvent extends AddListEvent {
  final Color color;
  int indexSelect;

  SelectColorEvent({@required this.color, this.indexSelect});
}

class ActiveAddBtn extends AddListEvent {
  final String text;

  ActiveAddBtn({this.text});
}

class CreateListEvent extends AddListEvent {
  final String name;
  final String color;
  final String createAt;
  final String lastUpdate;

  CreateListEvent({
    @required this.name,
    @required this.color,
    @required this.createAt,
    @required this.lastUpdate,
  });
}

class PopAddListGroupEvent extends AddListEvent {
  final bool isRemove;

  PopAddListGroupEvent({this.isRemove});
}
