import 'package:counter_app/events/counter_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc() : super(0);

  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);
}
