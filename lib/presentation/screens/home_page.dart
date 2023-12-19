import 'package:bloc_and_firebase/business_logic/cubit/auth_google_cubit.dart';
import 'package:bloc_and_firebase/business_logic/cubit/firebase_auth_cubit.dart';
import 'package:bloc_and_firebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class homescreen extends StatefulWidget {
  const homescreen({
    super.key,
  });

  @override
  State<homescreen> createState() => _homescreenState();
}

class _homescreenState extends State<homescreen> {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocConsumer<FirebaseAuthCubit, FirebaseAuthState>(
            listener: (context, firebasestate) {
              // TODO: implement listener
            },
            builder: (context, firebasestate) {
              return BlocConsumer<AuthGoogleCubit, AuthGoogleState>(
                listener: (context, state) {},
                builder: (context, googlestate) {
                  return GestureDetector(
                      onTap: () {
                        if(firebasestate is FirebaseSigninSuccessful){
                          context.read<FirebaseAuthCubit>().FirebaseSignout();
                        }
                        // if(googlestate is GoogleSignoutloading){       // if we are using google signin for our project then enable this for signing out
                        //   context.read<AuthGoogleCubit>().Googlelogout();
                        // }
                      },
                      child: Icon(
                        Icons.logout,
                      ));
                },
              );
            },
          )
        ],
      ),
      body: Column(
        children: [
          Text('hello'),
          //Text(firebaseAuth.currentUser!.email!)
        ],
      ),
    );
  }
}
