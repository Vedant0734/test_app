part of 'timer_bloc.dart';

@immutable
abstract class TimerEvent {}

class StartTimer extends TimerEvent {}

class TimeUpEvent extends TimerEvent {}

class TimerInProgress extends TimerEvent {
  final int seconds;

  TimerInProgress(this.seconds) {
    print(seconds);
  }
}

class StopTimerEvent extends TimerEvent {}
