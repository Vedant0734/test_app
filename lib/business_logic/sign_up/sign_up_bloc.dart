import 'package:bgi_test_app/business_logic/sign_in/repo.dart';
import 'package:bgi_test_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthenticationRepository _authenticationRepository = AuthenticationRepository();
  SignUpBloc() : super(SignUpInitial()) {
    on<SignUpRequested>((event, emit) async {
      emit(SignUpInProgressState());
      try {
        // await authService
        //   .signUpWithEmailAndPassword(email, password)
        //   .then((value) {
        // Map<String, String> userInfo = {
        //   "Name": name,
        //   "email": email,
        //   "password": password,
        //   "phone": number
        // };

        // databaseService.addUser(userInfo);

        // Constants.saveUserLoggedInSharedPreference(true);
        // });
        User user = await _authenticationRepository.signUp(event.uniqueId, event.password);
        emit(SignUpSuccessState(user));
      } catch (e) {
        emit(SignUpFailedState());
      }
    });
  }
}
