import 'package:ghichu/domain/entities/group_entity.dart';

abstract class HomePageEvent {}

class UpDate extends HomePageEvent {}

class UpDateGroupEvent extends HomePageEvent {}

class UpDateReminderEvent extends HomePageEvent {}

class OrderGroupEvent extends HomePageEvent {
  final int oldIndex;
  final int newIndex;

  OrderGroupEvent({this.newIndex, this.oldIndex});
}

class OrderGroupSystemEvent extends HomePageEvent {
  final int oldIndex;
  final int newIndex;

  OrderGroupSystemEvent({this.newIndex, this.oldIndex});
}

class EditEvent extends HomePageEvent {
  final bool isEdit;

  EditEvent({this.isEdit});
}
class SlideIsOpenEvent extends HomePageEvent{
  final bool isOpen;

  SlideIsOpenEvent({this.isOpen});
}
