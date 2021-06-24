import 'package:equatable/equatable.dart';

class PriorityState extends Equatable {
  final int indexCheck;
  PriorityState({this.indexCheck});
  PriorityState update({int indexCheck}) =>
      PriorityState(indexCheck: indexCheck ?? this.indexCheck);
  @override
  List<Object> get props => [this.indexCheck];
}
