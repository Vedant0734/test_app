import 'package:bgi_test_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final User user;
  UserBloc({required this.user}) : super(UserInitial(user)) {
    on<UserEvent>((event, emit) {
      
    });
  }
}
