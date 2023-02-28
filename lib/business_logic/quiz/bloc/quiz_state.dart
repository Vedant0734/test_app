part of 'quiz_bloc.dart';

@immutable
abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuestionsLoadInProgress extends QuizState {}

class QuestionsLoadFailedState extends QuizState {
  final String reason;
  QuestionsLoadFailedState({this.reason = "Something went wrong."});
}

class QuestionsLoadedState extends QuizState {
  final List<Question> questions;

  QuestionsLoadedState(this.questions);
}
