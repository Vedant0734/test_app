import 'package:bgi_test_app/services/remote_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'password_change_state.dart';

class PasswordChangeCubit extends Cubit<PasswordChangeState> {
  PasswordChangeCubit() : super(PasswordChangeInitial());

  void changePassword(String userId, String currentPassword, String newPassword) async {
    try {
      RemoteServerService remoteServer = RemoteServerService();
      await remoteServer.changePassword(userId, currentPassword, newPassword);
      emit(PasswordChangeSuccess());
    } catch (e) {
      emit(PasswordChangeFailedState());
    }
  }
}
