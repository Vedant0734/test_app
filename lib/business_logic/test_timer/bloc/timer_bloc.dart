import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

part 'timer_event.dart';
part 'timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  // late final Timer timer =
  //     Timer(Duration(seconds: 10), () => add(TimeUpEvent()));
  late Stream timerStream;
  // StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required int totalSeconds}) : super(TimerInitial(totalSeconds)) {
    timerStream = TimerProvider().secondsTick(totalSeconds);
    // timer.on<TimerStarted>(_onStarted);
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
  }

  @override
  Future<void> close() {
    // timerStream.
    // _tickerSubscription?.cancel();
    return super.close();
  }

  // void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
  //   emit(TimerRunInProgress(event.duration));
  //   _tickerSubscription?.cancel();
  //   _tickerSubscription = _ticker
  //       .tick(ticks: event.duration)
  //       .listen((duration) => add(TimerTicked(duration: duration)));
  // }

  // void _onStopped(TimerStopped timerStopped, Emitter<TimerState> emit) {
  //   emit(TimerStoppedState());
  // }

  // void _onTicked(TimerTicked event, Emitter<TimerState> emit) {
  //   emit(
  //     event.duration > 0
  //         ? TimerRunInProgress(event.duration)
  //         : TimerRunComplete(),
  //   );
  // }
}

class TimerProvider {
  Stream<int> secondsTick(int totalSeconds) {
    return Stream.periodic(
            const Duration(seconds: 1), (second) => totalSeconds - second - 1)
        .take(totalSeconds);
  }
}
