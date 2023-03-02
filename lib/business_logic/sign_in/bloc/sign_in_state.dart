part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

class SignInInProgressState extends SignInState {}

class SignInFailedState extends SignInState {
  final String reason;

  SignInFailedState({this.reason="Something went wrong."});
}

class SignInSuccessState extends SignInState {
  final User user;

  SignInSuccessState(this.user);
}