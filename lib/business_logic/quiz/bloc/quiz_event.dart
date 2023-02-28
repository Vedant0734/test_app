part of 'quiz_bloc.dart';

@immutable
abstract class QuizEvent {}

class LoadQuestionsEvent extends QuizEvent {
  final String quizId;

  LoadQuestionsEvent(this.quizId);
}
