abstract class ListGroupEvent {}

class SelectGroupEvent extends ListGroupEvent {
  final int indexSelect;

  SelectGroupEvent(this.indexSelect);
}
