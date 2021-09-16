part of 'counter_cubit.dart';

class CounterState {
  int counterValue;
  // In order to create the BlocListener we are creating here a bool that will return true when incremented and false when decremented
  // We doing this so later we can show a popup in the screen with 'value incremented' or 'value decremented'
  bool wasIncremented;
  CounterState({required this.counterValue, required this.wasIncremented});
}
