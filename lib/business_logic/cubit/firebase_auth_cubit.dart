import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'firebase_auth_state.dart';

class FirebaseAuthCubit extends Cubit<FirebaseAuthState> {
  FirebaseAuthCubit() : super(FirebaseAuthInitial());
  final _auth = FirebaseAuth.instance;

  void FirebaseSignup(String email, String password) async{
    emit(FirebaseAuthLoading());
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      emit(FirebaseAuthSuccessful(user: userCredential.user!));
      print(userCredential.user!.email!);
    } catch (e) {
      emit(FirebaseAuthFailed(error: e.toString()));
      
    }
  }

  void FirebaseSignIn(String email, String password) async{
    emit(FirebaseSigninLoading());
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      emit(FirebaseSigninSuccessful(user: userCredential.user!));
      print(userCredential.user!.email!);
    } catch (e) {
      emit(FirebaseSigninFailed(error: e.toString()));
      
    }
  }
  void FirebaseSignout() async{
    emit(FirebaseSignoutLoading());
    try {
     await _auth.signOut();
     emit(FirebaseSignoutSuccessful());
     emit(FirebaseAuthInitial());
    } catch (e) {
      emit(FirebaseAuthFailed(error: e.toString()));
      
    }
  }

}
