import 'package:equatable/equatable.dart';

class ListGroupState extends Equatable {
  final int indexCheck;
  ListGroupState({this.indexCheck});
  ListGroupState update({int indexCheck}) =>
      ListGroupState(indexCheck: indexCheck ?? this.indexCheck);
  @override
  List<Object> get props => [this.indexCheck];
}
