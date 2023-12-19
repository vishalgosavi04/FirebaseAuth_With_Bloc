part of 'firebase_auth_cubit.dart';

@immutable
sealed class FirebaseAuthState {}

final class FirebaseAuthInitial extends FirebaseAuthState {}

class FirebaseAuthLoading extends FirebaseAuthState{}

class FirebaseAuthSuccessful extends FirebaseAuthState{
  final User user;
  FirebaseAuthSuccessful({required this.user});
}

class FirebaseAuthFailed extends FirebaseAuthState{
  final String error;
  FirebaseAuthFailed({required this.error});
}

class FirebaseSigninLoading extends FirebaseAuthState{}

class FirebaseSigninSuccessful extends FirebaseAuthState{
  final User user;
  FirebaseSigninSuccessful({required this.user});
}

class FirebaseSigninFailed extends FirebaseAuthState{
  final String error;
  FirebaseSigninFailed({required this.error});
}


class FirebaseSignoutLoading extends FirebaseAuthState{}

class FirebaseSignoutSuccessful extends FirebaseAuthState{}

class FirebaseSignoutFailed extends FirebaseAuthState{
  final String error;
  FirebaseSignoutFailed({required this.error});
}