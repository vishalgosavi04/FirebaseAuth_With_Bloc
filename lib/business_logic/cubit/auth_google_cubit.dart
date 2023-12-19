import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

part 'auth_google_state.dart';

class AuthGoogleCubit extends Cubit<AuthGoogleState> {
  AuthGoogleCubit() : super(AuthGoogleInitial());
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;
  void GoogleLogin()async{
    emit(AuthGoogleloading());

    try {
      final _useraccount = await _googleSignIn.signIn();
      if(_useraccount == null) return;

      final GoogleSignInAuthentication googleauth = await _useraccount.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleauth.accessToken,
        idToken: googleauth.idToken
      );
      final userCredential = await _auth.signInWithCredential(credential);
      emit(AuthGoogleSuccess(user: userCredential.user!));
      print(userCredential.user!.displayName);
    } catch (e) {
      emit(AuthGoogleFailed(error: e.toString()));      
    }
  }

  void Googlelogout() async{
    emit(GoogleSignoutloading());
    try {
      await _auth.signOut();
       // Sign out with google
        await _googleSignIn.signOut();
    emit(GoogleSignoutSuccessful());
    } catch (e) {
      emit(GoogleSignoutFailed(error: e.toString()));
      
    }
  }
}
