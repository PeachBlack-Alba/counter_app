// ignore_for_file: prefer_const_constructors

import 'package:counter_app/logic/cubit/counter_cubit.dart';
import 'package:counter_app/presentation/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({Key? key, required this.title, required this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body:
      // This is how we would use the BlocListener, but there is an easier way to do it
      // With the BlocConsumer -> Combines BlocBuilder and BlocListener in one
//      BlocListener<CounterCubit, CounterState>(
//        listener: (context, state) {
//          if (state.wasIncremented == true) {
//            Scaffold.of(context).showSnackBar(const SnackBar(
//              content: Text('Incremented'),
//              duration: Duration(milliseconds: 300),
//            ));
//          } else if (state.wasIncremented == false) {
//            Scaffold.of(context).showSnackBar(const SnackBar(
//              content: Text('Decremented'),
//              duration: Duration(milliseconds: 300),
//            ));
//          }
//        },
//        child:
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            // We wrap it in here because is the UI that we wants to change when states is changed
            // Wrapping the whole screen would be a bad practice because we would be rebuilding the whole screen for just one number
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('Incremented'),
                    duration: Duration(milliseconds: 300),
                  ));
                } else if (state.wasIncremented == false) {
                  Scaffold.of(context).showSnackBar(const SnackBar(
                    content: Text('Decremented'),
                    duration: Duration(milliseconds: 300),
                  ));
                }
              },
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'Negative value' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (state.counterValue % 2 == 0) {
                  return Text(
                    'Value is even' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headline4,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  onPressed: () {
                    // we need to call the instance of the logic.cubit:
                    // two ways of doing it:
                    // BlocProvider.of<CounterCubit>(context).decrement;
                    // context.bloc<CounterCubit>().decrement();
                    // Now that we build the BlocProvider we need to change the UI and show how many times
                    // We pressed the button, for that, we need the BlocBuilder!
                    // The BlocBuilder is a widget that helps re-building the UI based on the bloc State Changes

                    BlocProvider.of<CounterCubit>(context).decrement;
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).increment();
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: widget.color,
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    // We use newContext instead of context because we want to create a newContext
                    builder: (newContext) => BlocProvider.value(
                      //If here we call the counterCubit provider, will take the counterCubit but when going to
                      // the next screen will do a new instance of it and what we want is an EXISTING instance of CounterCubit
                      // Otherwise, second screen would have a different state of the first and will defeat the propose of having one blocprovider
                      value: BlocProvider.of<CounterCubit>(context),
                      child: SecondScreen(
                        title: 'Second Screen',
                        color: Colors.indigoAccent,
                      ),
                    ),
                  ),
                );
              },
              child: Text('Go to second screen'),
            )
          ],
        ),
      ),
    );
  }
}
