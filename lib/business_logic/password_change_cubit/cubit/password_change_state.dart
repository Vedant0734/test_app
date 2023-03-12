part of 'password_change_cubit.dart';

@immutable
abstract class PasswordChangeState {}

class PasswordChangeInitial extends PasswordChangeState {}

class PasswordChangeInProgress extends PasswordChangeState {}

class PasswordChangeFailedState extends PasswordChangeState {
  final String reason;

  PasswordChangeFailedState({this.reason="Something went wrong."});
}

class PasswordChangeSuccess extends PasswordChangeState {}