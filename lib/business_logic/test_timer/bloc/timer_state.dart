part of 'timer_bloc.dart';

@immutable
abstract class TimerState {
  final int seconds;

  const TimerState(this.seconds);
}

class TimerInitial extends TimerState {
  const TimerInitial(super.seconds);
}

class TimerInProgressState extends TimerState {
  const TimerInProgressState(super.seconds);
}

class TimerStoppedState extends TimerState {
  const TimerStoppedState(super.seconds);
}

class TimeUpState extends TimerState {
  const TimeUpState(super.seconds);
}
