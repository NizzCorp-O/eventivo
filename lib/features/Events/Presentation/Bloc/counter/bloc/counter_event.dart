part of 'counter_bloc.dart';

 class CounterEvent {}

 class IncrementEvents extends CounterEvent{}
 class DegrimentEvents extends CounterEvent{}
 class ResetCount extends CounterEvent {
  final int initialCount;
  ResetCount({this.initialCount = 1});
}

