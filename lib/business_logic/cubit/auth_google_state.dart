part of 'auth_google_cubit.dart';

@immutable
sealed class AuthGoogleState {
}

final class AuthGoogleInitial extends AuthGoogleState {}
final class AuthGoogleloading extends AuthGoogleState{}

class AuthGoogleSuccess extends AuthGoogleState{
  final User user;
  AuthGoogleSuccess({required this.user});
}

class AuthGoogleFailed extends AuthGoogleState{
  final String error;
  AuthGoogleFailed({required this.error});
}

class GoogleSignoutloading extends AuthGoogleState{}
class GoogleSignoutSuccessful extends AuthGoogleState{}

class GoogleSignoutFailed extends AuthGoogleState{
  final String error;
  GoogleSignoutFailed({required this.error});
}