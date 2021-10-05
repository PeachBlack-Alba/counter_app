import 'package:counter_app/presentation/screens/home_screen.dart';
import 'package:counter_app/presentation/screens/second_screen.dart';
import 'package:counter_app/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit/counter_cubit.dart';

void main() {
  final CounterState counterState1 = CounterState(counterValue: 1);
  final CounterState counterState2 = CounterState(counterValue: 2);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {


  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    // Wrapping the MaterialApp inside a BlocProvider or MultiBlocProvider will provide all the blocs
    // And cubits GLOBALLY to all screens
    // And because we are doing that, we dont need a Stateful widget anymore
    return BlocProvider<CounterCubit>(
      create: (context) => CounterCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // We need to pass the function as an argument and not as a result of it
        onGenerateRoute: _appRouter.onGenerateRoute,

      ),
    );
  }

  @override
  void dispose() {
    // Close the CounterCubit
    _appRouter.dispose();
    super.dispose();
  }
}
