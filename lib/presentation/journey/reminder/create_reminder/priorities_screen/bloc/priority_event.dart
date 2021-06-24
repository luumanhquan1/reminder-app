abstract class PriorityEvent {}

class SelectPriortyEvent extends PriorityEvent {
  final int indexSelect;

  SelectPriortyEvent({this.indexSelect});
}
