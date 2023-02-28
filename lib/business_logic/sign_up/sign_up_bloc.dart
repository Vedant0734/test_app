import 'package:bgi_test_app/models/user.dart';
import 'package:bgi_test_app/services/auth.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../helper/constants.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  AuthService authService;
  SignUpBloc({required this.authService}) : super(SignUpInitial()) {
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
        User user = await authService.signUp(event.uniqueId, event.password);
        emit(SignUpSuccessState(user));
      } catch (e) {
        emit(SignUpFailedState());
      }
    });
  }
}
