import 'package:counter_app/presentation/screens/home_screen.dart';
import 'package:counter_app/presentation/screens/second_screen.dart';
import 'package:counter_app/presentation/screens/third_screen.dart';
import 'package:flutter/material.dart';



/////// Provide a cubit/ bloc instance GLOBALLY

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    final GlobalKey<ScaffoldState> key = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => HomeScreen(
            title: "Home Screen",
            color: Colors.blueAccent,
          ),
        );
      case '/second':
        return MaterialPageRoute(
          builder: (_) => SecondScreen(
            title: "Second Screen",
            color: Colors.redAccent,
            homeScreenKey: key,
          ),
        );
      case '/third':
        return MaterialPageRoute(
          builder: (_) => ThirdScreen(
            title: "Thirst Screen",
            color: Colors.greenAccent,
          ),
        );
      default:
        return null;
    }
  }
}





/////// Provide a cubit/ bloc instance SPECIFICALLY:
//class AppRouter {
//  // We want to create an existing instance of a bloc or Cubit to each of our screens
//  // But we cant create a new instance for each screen
//  // Thats why we create it here for all the screens:
//
//  final CounterCubit _counterCubit = CounterCubit();
//
//  Route onGenerateRoute(RouteSettings settings) {
//    final GlobalKey<ScaffoldState> key = settings.arguments;
//    switch (settings.name) {
//      case '/':
//        return MaterialPageRoute(
//          builder: (_) => BlocProvider.value(
//            value: _counterCubit,
//            child: HomeScreen(
//              title: "Home Screen",
//              color: Colors.blueAccent,
//            ),
//          ),
//        );
//      case '/second':
//        return MaterialPageRoute(
//          builder: (_) => BlocProvider.value(
//            value: _counterCubit,
//            child: SecondScreen(
//              title: "Second Screen",
//              color: Colors.redAccent,
//              homeScreenKey: key,
//            ),
//          ),
//        );
//      case '/third':
//        return MaterialPageRoute(
//          builder: (_) => BlocProvider.value(
//            value: _counterCubit,
//            child: ThirdScreen(
//              title: "Thirst Screen",
//              color: Colors.greenAccent,
//            ),
//          ),
//        );
//      default:
//        return null;
//    }
//  }
//
//  void dispose(){
//    _counterCubit.close();
//  }
//}
