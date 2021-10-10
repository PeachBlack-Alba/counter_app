import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:counter_app/constants/enums.dart';
import 'package:counter_app/logic/cubit/internet_cubit.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

/////////////////////// USING BLOCLISTENER

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counterValue: 0));

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncremented: true));

  void decrement() => emit(CounterState(
      counterValue: state.counterValue - 1, wasIncremented: false));
}


////////////////// USING STREAMSUBSCRIPTIONS
//class CounterCubit extends Cubit<CounterState> {
//  final InternetCubit internetCubit;
//  StreamSubscription internetStreamSubscription;
//
//  CounterCubit(@required this.internetCubit) : super(CounterState(counterValue: 0)) {
//    monitoredCubit();
//  }
//
//  StreamSubscription<InternetState> monitoredCubit() {
//    return internetStreamSubscription = internetCubit.listen((internetState) {
//    if (internetState is InternetConnected && internetState.connectionType == ConnectionType.Wifi) {
//      increment();
//    } else if (internetState is InternetConnected && internetState.connectionType == ConnectionType.Mobile) {
//      decrement();
//    }
//  });
//  }
//
//  void increment() => emit(CounterState(
//        counterValue: state.counterValue + 1,
//        wasIncremented: true,
//      ));
//
//  // void increment emit a new state => 1
//  void decrement() => emit(CounterState(
//        counterValue: state.counterValue - 1,
//        wasIncremented: false,
//      ));
//  @override
//  Future<void> close() {
//    internetStreamSubscription.cancel()
//    return super.close();
//  }
//}
