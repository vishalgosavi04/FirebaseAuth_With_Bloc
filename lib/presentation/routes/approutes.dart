import 'package:bloc_and_firebase/business_logic/cubit/auth_google_cubit.dart';
import 'package:bloc_and_firebase/main.dart';
import 'package:bloc_and_firebase/presentation/screens/home_page.dart';
import 'package:bloc_and_firebase/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Approute{
  final AuthGoogleCubit _authGoogleCubit = AuthGoogleCubit();
  Route? ongenerateRoute(RouteSettings routeSettings){
    switch (routeSettings.name) {
      case '/':
          return MaterialPageRoute(
            builder: (_)=> BlocProvider.value(
              value: _authGoogleCubit,
              child: AppWraper(),
              ) );
          
      case '/second': 
          return MaterialPageRoute(
            builder: (_)=> BlocProvider.value(
              value: _authGoogleCubit,
              child: LoginPage(),
              ));
      default:
      return null;
    }
  }
  void dispose(){
    _authGoogleCubit.close();
  }
}