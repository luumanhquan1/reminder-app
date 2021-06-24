import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/priorities_screen/bloc/priority_event.dart';
import 'package:ghichu/presentation/journey/reminder/create_reminder/priorities_screen/bloc/priority_state.dart';

class PriorityBloc extends Bloc<PriorityEvent, PriorityState> {
  @override
  // TODO: implement initialState
  PriorityState get initialState => PriorityState(indexCheck: 0);

  @override
  Stream<PriorityState> mapEventToState(PriorityEvent event) async* {
    if (event is SelectPriortyEvent) {
      yield* _mapSelectPriorityToState(event);
    }
  }

  Stream<PriorityState> _mapSelectPriorityToState(
      SelectPriortyEvent event) async* {
    yield state.update(indexCheck: event.indexSelect);
  }
}
