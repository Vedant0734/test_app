import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'warning_event.dart';
part 'warning_state.dart';

class WarningBloc extends Bloc<WarningEvent, WarningState> {
  WarningBloc() : super(const WarningInitial()) {
    on<WarnUser>((event, emit) {
      if(state.warningCount > 3){
        emit(EndQuizState(warningCount: state.warningCount));
      } else {
        emit(WarningUpdatedState(warningCount: state.warningCount+1));
      }
    });
  }
}
