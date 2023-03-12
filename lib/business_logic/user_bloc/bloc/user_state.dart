part of 'user_bloc.dart';

@immutable
abstract class UserState {
  final User currentUser;

  const UserState(this.currentUser);
}

class UserInitial extends UserState {
  const UserInitial(super.currentUser);
}
