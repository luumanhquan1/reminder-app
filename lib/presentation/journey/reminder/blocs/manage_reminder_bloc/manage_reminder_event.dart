import 'package:flutter/cupertino.dart';
import 'package:ghichu/domain/entities/group_entity.dart';

abstract class ManageReminderEvent{}
class GetDataReminderAllEvent extends ManageReminderEvent{
  final List<GroupEntity> listGroup;

  GetDataReminderAllEvent({@required this.listGroup});
}
class GetDataScheduled extends ManageReminderEvent{

}