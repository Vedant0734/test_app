part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SignInRequested extends SignInEvent {
  final String uniqueId, password;

  SignInRequested({required this.uniqueId, required  this.password});
}