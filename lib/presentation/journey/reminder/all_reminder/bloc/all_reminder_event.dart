import 'package:flutter/cupertino.dart';
import 'package:ghichu/domain/entities/group_entity.dart';

abstract class AllReminderEvent {}
class GetDataReminderEvent extends AllReminderEvent{
 final List<GroupEntity> listGroup;

  GetDataReminderEvent({@required this.listGroup});
}