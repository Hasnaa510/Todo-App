import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'Counter/counter.dart';
import 'Counter/cubit/bloc_observer.dart';
import 'Login/login_screen.dart';
import 'TODO/home_layout.dart';
//import 'NEWS/dio.dart';
//import 'NEWS/news_layout.dart';
//import 'TODO/home_layout.dart';

void main() {

 // DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp( MyApp());

  //hasnaa100%*
  //

}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
            elevation: 0,
          color: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 25,

          )
        )
      ),
      debugShowCheckedModeBanner: false,
      home:HomeLayout(),
    );
  }
}
