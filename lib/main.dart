import 'dart:io';

import 'package:bloc_and_firebase/business_logic/cubit/auth_google_cubit.dart';
import 'package:bloc_and_firebase/business_logic/cubit/firebase_auth_cubit.dart';
import 'package:bloc_and_firebase/presentation/screens/home_page.dart';
import 'package:bloc_and_firebase/presentation/screens/login_screen.dart';
import 'package:bloc_and_firebase/presentation/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_and_firebase/presentation/routes/approutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyBRpfUYuBcfj6V22kAG9Lnvq6xVxt1p9Os",
              appId: "1:285768458615:android:38f74640ffba3c102d0172",
              messagingSenderId: "285768458615",
              projectId: "fir-withbloc-5ea7f"))
      : Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Approute _approute = Approute();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthGoogleCubit(),
        ),
        BlocProvider(
          create: (context) => FirebaseAuthCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: _approute.ongenerateRoute,
        title: 'Flutter Demo',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            fontFamily: 'poppins'),
      ),
    );
  }

  @override
  void dispose() {
    _approute.dispose();
  }
}

class AppWraper extends StatelessWidget {
  const AppWraper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FirebaseAuthCubit, FirebaseAuthState>(
      builder: (context, firebasestate) {
        return BlocBuilder<AuthGoogleCubit, AuthGoogleState>(
          builder: (context, googlestate) {             // it totally depends on the condition that we are going to use email or google sign in then adjust routing accordingly
            if (firebasestate is FirebaseAuthInitial) {
              return SignupPage();
            } 
            else if (firebasestate is FirebaseAuthSuccessful) {
              return LoginPage();
            } 
            else if(firebasestate is FirebaseSigninSuccessful){
              return homescreen();
            }
            else if(firebasestate is FirebaseSignoutSuccessful){
              return LoginPage();
            }
            else {
              return SizedBox();
            }
          },
        );
      },
    );
  }
}
