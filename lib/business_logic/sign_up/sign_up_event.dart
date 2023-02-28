part of 'sign_up_bloc.dart';

@immutable
abstract class SignUpEvent {}

class SignUpRequested extends SignUpEvent {
  final String uniqueId, password;

  SignUpRequested({required this.uniqueId, required this.password});
}

class SignUpFailedEvent extends SignUpEvent {}

class SignUpSuccessEvent extends SignUpEvent {}
