import 'package:counter_app/constants/enums.dart';
import 'package:counter_app/logic/cubit/counter_cubit.dart';
import 'package:counter_app/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/////////////// USING STREAMSUBSCRIPTION
class HomeScreen extends StatefulWidget {
  HomeScreen({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext homeScreenContext) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            BlocBuilder<InternetCubit, InternetState>(
              builder: (context, state) {
                if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Wifi) {
                  return Text(
                    'Wi-Fi',
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                      color: Colors.green,
                    ),
                  );
                } else if (state is InternetConnected &&
                    state.connectionType == ConnectionType.Mobile) {
                  return Text(
                    'Mobile',
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                      color: Colors.red,
                    ),
                  );
                } else if (state is InternetDisconnected) {
                  return Text(
                    'Disconnected',
                    style: Theme.of(context).textTheme.headline3?.copyWith(
                      color: Colors.grey,
                    ),
                  );
                }
                return CircularProgressIndicator();
              },
            ),
            Divider(
              height: 5,
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  Scaffold.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Incremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  Scaffold.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decremented!'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state.counterValue < 0) {
                  return Text(
                    'BRR, NEGATIVE ' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (state.counterValue % 2 == 0) {
                  return Text(
                    'YAAAY ' + state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else if (state.counterValue == 5) {
                  return Text(
                    'HMM, NUMBER 5',
                    style: Theme.of(context).textTheme.headline4,
                  );
                } else {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                }
              },
            ),
            Builder(
              builder: (context) {
                final counterState = context.watch<CounterCubit>().state;
                final internetState = context.watch<InternetCubit>().state;

                if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.Mobile) {
                  return Text(
                    'Counter: ' +
                        counterState.counterValue.toString() +
                        ' Internet: Mobile',
                    style: Theme.of(context).textTheme.headline6,
                  );
                } else if (internetState is InternetConnected &&
                    internetState.connectionType == ConnectionType.Wifi) {
                  return Text(
                    'Counter: ' +
                        counterState.counterValue.toString() +
                        ' Internet: Wifi',
                    style: Theme.of(context).textTheme.headline6,
                  );
                } else {
                  return Text(
                    'Counter: ' +
                        counterState.counterValue.toString() +
                        ' Internet: Disconnected',
                    style: Theme.of(context).textTheme.headline6,
                  );
                }
              },
            ),
            const SizedBox(
              height: 24,
            ),
            /// Context.select();
            Builder(
              builder: (context) {
                final counterValue = context
                    .select((CounterCubit cubit) => cubit.state.counterValue);
                return Text(
                  'Counter: ' + counterValue.toString(),
                  style: Theme.of(context).textTheme.headline6,
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                  heroTag: Text('${widget.title}'),
                  onPressed: () {
                    BlocProvider.of<CounterCubit>(context).decrement();
                    // context.bloc<CounterCubit>().decrement();
                  },
                  tooltip: 'Decrement',
                  child: Icon(Icons.remove),
                ),
                FloatingActionButton(
                  heroTag: Text('${widget.title} 2nd'),
                  onPressed: () {
                    // BlocProvider.of<CounterCubit>(context).increment();
                    context.read<CounterCubit>().increment();
                  },
                  tooltip: 'Increment',
                  child: Icon(Icons.add),
                ),
              ],
            ),
            Builder(
              // Wrapping the widget in a builder so we can specify which
              // context has to look to, since the MaterialButton context is anonymous
              // and therefore is not accessible
              // The look for the context is bottom-up relationship
              builder: (materialButtonContext) {
                return MaterialButton(
                  color: Colors.redAccent,
                  child: const Text(
                    'Go to Second Screen',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(materialButtonContext).pushNamed(
                      '/second',
                    );
                  },
                );
              }
            ),
            SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: Colors.greenAccent,
              child: const Text(
                'Go to Third Screen',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(homeScreenContext).pushNamed(
                  '/third',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}



//// ignore_for_file: prefer_const_constructors
//
//import 'package:counter_app/constants/enums.dart';
//import 'package:counter_app/logic/cubit/counter_cubit.dart';
//import 'package:counter_app/logic/cubit/internet_cubit.dart';
//import 'package:counter_app/presentation/screens/second_screen.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//
//class HomeScreen extends StatefulWidget {
//  const HomeScreen({Key? key, required this.title, required this.color}) : super(key: key);
//
//  final String title;
//  final Color color;
//
//  @override
//  State<HomeScreen> createState() => _HomeScreenState();
//}
//
//class _HomeScreenState extends State<HomeScreen> {
//  int _counter = 0;
//
//  void _incrementCounter() {
//    setState(() {
//      _counter++;
//    });
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return BlocListener<InternetCubit, InternetState>(
//        listener: (context, state) {
//          if (state is InternetConnected && state.connectionType == ConnectionType.Wifi) {
//            context.bloc<CounterCubit>().increment();
//          } else if (state is InternetConnected && state.connectionType == ConnectionType.Mobile) {
//            context.bloc<CounterCubit>().decrement();
//          }
//        },
//        child: Scaffold(
//          appBar: AppBar(
//            backgroundColor: widget.color,
//            title: Text(widget.title),
//          ),
//          body:
//              // This is how we would use the BlocListener, but there is an easier way to do it
//              // With the BlocConsumer -> Combines BlocBuilder and BlocListener in one
////      BlocListener<CounterCubit, CounterState>(
////        listener: (context, state) {
////          if (state.wasIncremented == true) {
////            Scaffold.of(context).showSnackBar(const SnackBar(
////              content: Text('Incremented'),
////              duration: Duration(milliseconds: 300),
////            ));
////          } else if (state.wasIncremented == false) {
////            Scaffold.of(context).showSnackBar(const SnackBar(
////              content: Text('Decremented'),
////              duration: Duration(milliseconds: 300),
////            ));
////          }
////        },
////        child:
//              Center(
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
//                const Text(
//                  'You have pushed the button this many times:',
//                ),
//                // We wrap it in here because is the UI that we wants to change when states is changed
//                // Wrapping the whole screen would be a bad practice because we would be rebuilding the whole screen for just one number
//                BlocConsumer<CounterCubit, CounterState>(
//                  listener: (context, state) {
//                    if (state.wasIncremented == true) {
//                      Scaffold.of(context).showSnackBar(const SnackBar(
//                        content: Text('Incremented'),
//                        duration: Duration(milliseconds: 300),
//                      ));
//                    } else if (state.wasIncremented == false) {
//                      Scaffold.of(context).showSnackBar(const SnackBar(
//                        content: Text('Decremented'),
//                        duration: Duration(milliseconds: 300),
//                      ));
//                    }
//                  },
//                  builder: (context, state) {
//                    if (state.counterValue < 0) {
//                      return Text(
//                        'Negative value' + state.counterValue.toString(),
//                        style: Theme.of(context).textTheme.headline4,
//                      );
//                    } else if (state.counterValue % 2 == 0) {
//                      return Text(
//                        'Value is even' + state.counterValue.toString(),
//                        style: Theme.of(context).textTheme.headline4,
//                      );
//                    }
//                    return Text(
//                      state.counterValue.toString(),
//                      style: Theme.of(context).textTheme.headline4,
//                    );
//                  },
//                ),
//                Row(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: [
//                    FloatingActionButton(
//                      onPressed: () {
//                        // we need to call the instance of the logic.cubit:
//                        // two ways of doing it:
//                        // BlocProvider.of<CounterCubit>(context).decrement;
//                        // context.bloc<CounterCubit>().decrement();
//                        // Now that we build the BlocProvider we need to change the UI and show how many times
//                        // We pressed the button, for that, we need the BlocBuilder!
//                        // The BlocBuilder is a widget that helps re-building the UI based on the bloc State Changes
//
//                        BlocProvider.of<CounterCubit>(context).decrement;
//                      },
//                      tooltip: 'Decrement',
//                      child: Icon(Icons.remove),
//                    ),
//                    FloatingActionButton(
//                      onPressed: () {
//                        BlocProvider.of<CounterCubit>(context).increment();
//                      },
//                      tooltip: 'Increment',
//                      child: Icon(Icons.add),
//                    )
//                  ],
//                ),
//                SizedBox(
//                  height: 24,
//                ),
//                MaterialButton(
//                  color: widget.color,
//                  onPressed: () {
//                    /// Navigating with named routing
//                    Navigator.of(context).pushNamed('/second'
//
//                        /// Navigating with anonymous routing
////                  MaterialPageRoute(
////                    // We use newContext instead of context because we want to create a newContext
////                    builder: (newContext) => BlocProvider.value(
////                      //If here we call the counterCubit provider, will take the counterCubit but when going to
////                      // the next screen will do a new instance of it and what we want is an EXISTING instance of CounterCubit
////                      // Otherwise, second screen would have a different state of the first and will defeat the propose of having one blocprovider
////                      value: BlocProvider.of<CounterCubit>(context),
////                      child: SecondScreen(
////                        title: 'Second Screen',
////                        color: Colors.indigoAccent,
////                      ),
////                    ),
////                  ),
//                        );
//                  },
//                  child: Text('Go to second screen'),
//                ),
//                SizedBox(
//                  height: 24,
//                ),
//                MaterialButton(
//                  color: widget.color,
//                  onPressed: () {
//                    /// Navigating with named routing
//                    Navigator.of(context).pushNamed('/third'
//
//                        /// Navigating with anonymous routing
////                  MaterialPageRoute(
////                    builder: (newContext) => BlocProvider.value(
////                      value: BlocProvider.of<CounterCubit>(context),
////                      child: SecondScreen(
////                        title: 'Second Screen',
////                        color: Colors.indigoAccent,
////                      ),
////                    ),
////                  ),
//                        );
//                  },
//                  child: Text('Go to third screen'),
//                ),
//              ],
//            ),
//          ),
//        ));
//  }
//}
