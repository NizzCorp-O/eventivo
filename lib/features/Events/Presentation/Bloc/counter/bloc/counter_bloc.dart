import 'package:bloc/bloc.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterInitial(count: 1)) {
    on<IncrementEvents>((event, emit) {
      emit(CounterState(count: state.count + 1));
    });

    on<DegrimentEvents>((event, emit) {
      if (state.count > 0) {
        emit(CounterState(count: state.count - 1));
      } else {
        emit(CounterState(count: 0));
      }
    });
    on<ResetCount>((event, emit) {
      emit(CounterState(count: event.initialCount));
    });
  }
}
