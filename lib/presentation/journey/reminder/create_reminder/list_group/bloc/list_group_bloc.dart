import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/list_group/bloc/list_group_event.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/list_group/bloc/list_group_state.dart';

class ListGroupBloc extends Bloc<ListGroupEvent, ListGroupState> {
  @override
  // TODO: implement initialState
  ListGroupState get initialState => ListGroupState(indexCheck: 0);

  @override
  Stream<ListGroupState> mapEventToState(ListGroupEvent event) async* {
    if (event is SelectGroupEvent) {
      yield* _mapSelectGroupToState(event);
    }
  }

  Stream<ListGroupState> _mapSelectGroupToState(SelectGroupEvent event) async* {
    yield state.update(indexCheck: event.indexSelect);
  }
}
