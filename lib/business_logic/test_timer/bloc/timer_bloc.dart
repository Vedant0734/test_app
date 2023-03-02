import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  late Stream timerStream;
  // late final StreamSubscription<int> _tickerSubscription;

  TimerBloc({required int totalSeconds}) : super(TimerInitial(totalSeconds)) {
    timerStream = TimerProvider().secondsTick(totalSeconds);
    // _tickerSubscription = TimerProvider().secondsTick(totalSeconds).listen((event) { });
    timerStream.listen((seconds) {
      print("total seconds left" + seconds.toString());
      if (seconds == 0) {
        add(TimeUpEvent());
      } else {
        add(TimerInProgress(seconds));
      }
    });
    // _tickerSubscription = timer.secondsTick(6).;
    // TimerProvider().secondsTick(50).;
    on<TimeUpEvent>((event, emit) {
      emit(TimeUpState(0));
    });
    on<TimerInProgress>((event, emit) {
      emit(TimerInProgressState(event.seconds));
    });
    on<StopTimerEvent>((event, emit) {
      // timerStream.
    });
  }

  @override
  Future<void> close() {
    
    return super.close();
  }
}

class TimerProvider {
  Stream<int> secondsTick(int totalSeconds) {
    return Stream.periodic(
            const Duration(seconds: 1), (second) => totalSeconds - second - 1)
        .take(totalSeconds);
  }
}
