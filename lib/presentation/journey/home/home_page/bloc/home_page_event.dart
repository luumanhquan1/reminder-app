import 'package:ghichu/domain/entities/group_entity.dart';

abstract class HomePageEvent {}

class UpDate extends HomePageEvent {}

class UpDateGroupEvent extends HomePageEvent {}

class UpDateReminderEvent extends HomePageEvent {}

class EditGroupEvent extends HomePageEvent {
  final int index;
  EditGroupEvent(this.index);
}
class PushReminderSystemEvent extends HomePageEvent{
  final List<GroupEntity> listGroup;
  final String routeName;

  PushReminderSystemEvent({this.listGroup, this.routeName});
}
class ActiveSearchReminderEvent extends HomePageEvent{
  final bool isSearch;

  ActiveSearchReminderEvent({this.isSearch});
}
class SearchReminderHomeEvent extends HomePageEvent{
  final String search;

  SearchReminderHomeEvent(this.search);

}
class UpdateEditGroupEvent extends HomePageEvent {}

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

class SlideIsOpenEvent extends HomePageEvent {
  final bool isOpen;

  SlideIsOpenEvent({this.isOpen});
}

class DeleteGroupEvent extends HomePageEvent {
  final int index;
  final bool isDialog;
  DeleteGroupEvent({this.index, this.isDialog});
}

class PushMyListEvent extends HomePageEvent {
  final GroupEntity groupEntity;

  PushMyListEvent({this.groupEntity});
}

class PushAddGroupEvent extends HomePageEvent {}

class PushNewReminderEvent extends HomePageEvent {
  final List<GroupEntity> listGroup;

  PushNewReminderEvent({this.listGroup});
}
