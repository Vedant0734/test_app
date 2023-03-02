import 'package:bgi_test_app/business_logic/sign_in/repo.dart';
import 'package:bgi_test_app/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../errors/user_not_found.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
  SignInBloc() : super(SignInInitial()) {
    on<SignInRequested>((event, emit) async {
      emit(SignInInProgressState());
      try {
        final User user = await _authenticationRepository.signIn(event.uniqueId, event.password);
        emit(SignInSuccessState(user));
      } on UserNotFoundError {
        emit(SignInFailedState(reason: "The id and password are invalid."));
      } catch (e) {
        emit(SignInFailedState());
      }
    });
  }
}
