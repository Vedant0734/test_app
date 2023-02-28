part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpInProgressState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final User user;

  SignUpSuccessState(this.user);
}

class SignUpFailedState extends SignUpState {}
