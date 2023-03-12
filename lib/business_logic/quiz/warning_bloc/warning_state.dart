part of '../warning_bloc/warning_bloc.dart';

@immutable
abstract class WarningState {
  final int warningCount;

  const WarningState({required this.warningCount});
}

class WarningInitial extends WarningState {
  const WarningInitial({super.warningCount=0});
}

class WarningUpdatedState extends WarningState {
  const WarningUpdatedState({required super.warningCount});
}

class EndQuizState extends WarningState {
  const EndQuizState({required super.warningCount});
}